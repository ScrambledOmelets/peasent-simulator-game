extends Node #must handle all game code here

@export var hazard1: PackedScene
@export var hazard2: PackedScene
@export var choiceWindow: PackedScene

signal gameOver
#instanced scene variables
var dialouge
var hazard

#game values
#might need to make these global...
var gold : int
var food : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$player.resetPlayer($startPosition.position)
	$hud.update_message("")
	#checks for signals???
	SignalBus.playerHit.connect(_on_player_hit)
	#might have to diable these two signals later..
	SignalBus.choice1.connect(_on_first_choice1)
	SignalBus.choice2.connect(_on_first_choice2)
	#keep this one enabled
	SignalBus.choice_made.connect(_any_choice_made)
	#all the village entered signals going to the same function
	$villageTransition2.villageEntered.connect(_on_village_transition_village_entered)
	$villageTransition3.villageEntered.connect(_on_village_transition_village_entered)
	
	#disabling player movement for the talking thing to appear
	$player.set_physics_process(false)
	dialougeSpawn("you have set out on a new journey! what do you remember bringing?", "heavy load", "light load")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#hopefully checks for gameover without being buggy
	#it was buggy
	pass

#very first choice made to determine things
#i should probably have this in the main file and make the variables global again
func _on_first_choice1() -> void:
	food = 10
	gold = 15
	$hud.update_foodCounter(food)
	$hud.update_goldCounter(gold)
	dialouge.updateHeader("wonderful choice!")
	SignalBus.choice1.disconnect(_on_first_choice1)
	SignalBus.choice1.connect(_choice1_made)
	
	SignalBus.choice2.disconnect(_on_first_choice2)
	SignalBus.choice2.connect(_choice2_made)

func _on_first_choice2() -> void:
	food = 5
	gold = 10
	$hud.update_foodCounter(food)
	$hud.update_goldCounter(gold)
	dialouge.updateHeader("lovely choice!")
	#connecting and disconnecting other signals
	SignalBus.choice1.disconnect(_on_first_choice1)
	SignalBus.choice1.connect(_choice1_made)
	#they have to connect and disconnect for both
	#this is very complicated
	SignalBus.choice2.disconnect(_on_first_choice2)
	SignalBus.choice2.connect(_choice2_made)

func _any_choice_made() -> void:
	
	$choiceTimer.start()
	
func _choice1_made() -> void:
	#gen random number
	var num = randi_range(1, 5)
	#subtract from gold amt bc bandits
	gold -= num
	
	is_game_over(food, gold)
	#logic for gold
	dialouge.updateHeader(goldLogic(gold, num))
	
func _choice2_made() -> void:
	var num1 = randi_range(1, 5)
	var num2 = randi_range(1,3)
	gold -= num1
	food -= num2
	
	is_game_over(food, gold)
	#should update everything and return the value string to update header
	#wtf me when the code works (im shocked and surprised)
	dialouge.updateHeader(goldLogic(gold, num1) + foodLogic(food, num2) + " while escaping")
	
#this works
func _on_player_hit() -> void:
	#so mobs dont spawn when ur in choice
	$hazardTimer.stop()
	#stop player movement
	$player.set_physics_process(false)
	dialougeSpawn("oh no a bandit", "pay what they demand", "attempt escape")
	
#this also works fine
func _on_hazard_timer_timeout() -> void:
	#instance
	hazard = hazard2.instantiate()
	
	#getting spawn location (random)
	var hazard_spawn_location = $hazardPath/hazardSpawnLocation
	hazard_spawn_location.progress_ratio = randf()
	
	#perpendicular angling???
	var direction = hazard_spawn_location.rotation + PI/2
	
	#setting spawn to random
	hazard.position = hazard_spawn_location.position
	
	##VELOCITY/MOVEMENT HANDLED IN HAZARD SCRIPT
	
	#var velocity = Vector2(200, 0.0)
	#hazard.linear_velocity = velocity.rotated(direction)
	
	#hopefully this makes the thing move to the player
	#var dir = ($player.global_position - hazard.position).normalized()
	#
	##setting velocity
	#var velocity = Vector2(500, 0.0)
	#hazard.position += velocity * dir
	#
	#add instance as child
	add_child(hazard)
	print("child added...")


#spawning of new choice
#this also works???
func dialougeSpawn(header: String, option1: String, option2: String):
	#handle logic for each choice in different area when i start adding different types of events
	
	#instance
	dialouge = choiceWindow.instantiate()
	add_child(dialouge)
	
	#functions to update new choice
	dialouge.newChoiceWindow()
	dialouge.updateHeader(header)
	dialouge.updatedChoices(option1, option2)


func _on_choice_timer_timeout() -> void:
	#removes the dialouge
	remove_child(dialouge)
	#hopefully removes hazard w/o error
	remove_child(hazard)
	#spawn enemies at a random time (hopefully)
	$hazardTimer.start(randi_range(1, 5))
	$player.set_physics_process(true)
	
func goldLogic(gold, randomNum):
	var value = "you lost " + str(randomNum) + " gold..."
	
	if gold <= 0:
		$hud.update_goldCounter(0)
		gold = 0
		$hud.update_message("oh no! you've lost all your gold...")
		dialouge.updateHeader(value)
	else:
		#update values and continue game
		$hud.update_goldCounter(gold)
	
	return value

func foodLogic(food, randomNum):
	var value = str(randomNum) + " food..."
	
	if food <= 0:
		food = 0
		$hud.update_message("you cannot continue this journey...")
		dialouge.updateHeader("you've lost all your food!")
		$hud.update_foodCounter(food)
	else:
		$hud.update_foodCounter(food)
		
	return value

func is_game_over(food, gold):
	if food <= 0:
		$choiceTimer.start()
		await $choiceTimer.timeout
		gameOver.emit() #this works. connect signal
		print("NO FOOD")
	
	##this is glitchy, i don't like it
	elif gold < 0:
		$choiceTimer.start()
		await $choiceTimer.timeout
		gameOver.emit()
		print("RAN OUT OF GOLD")

#when player enters a village
func _on_village_transition_village_entered() -> void:
	$choiceTimer.start()
	$hud.update_message("now entering a village")
	$player.set_physics_process(false)
	$hazardTimer.stop()
	#waiting for timer
	await $choiceTimer.timeout
	#this would change to the village scene when i expand the game
	get_tree().change_scene_to_file("res://scenes/transition_scene.tscn")
	

#when the game ends
func _on_game_over() -> void:
	#this signal is never recieved bc this scene is deleted
	SignalBus.bring_to_end_screen.emit(food, gold)
	
	$player.set_physics_process(false)
	$hazardTimer.stop()
	get_tree().change_scene_to_file("res://scenes/transition_scene2.tscn")
