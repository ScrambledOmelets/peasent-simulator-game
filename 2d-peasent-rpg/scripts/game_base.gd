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
#mde them global

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#spawn mobs?
	banditSpawn()
	
	#setting up game
	$player.resetPlayer($startPosition.position)
	$hud.update_message("")
	
	##checks for signals???
	SignalBus.playerHit.connect(_on_player_hit)
	SignalBus.farried.connect(_on_player_farried)
	##might have to diable these two signals later..
	#SignalBus.choice1.connect(_on_first_choice1)
	#SignalBus.choice2.connect(_on_first_choice2)
	##keep this one enabled
	#SignalBus.choice_made.connect(_any_choice_made)
	#all the village entered signals going to the same function
	$villageTransition2.villageEntered.connect(_on_village_transition_village_entered)
	$villageTransition3.villageEntered.connect(_on_village_transition_village_entered)
	
	#ok this is properly connected
	DialogueManager.dialogue_ended.connect(_on_dialouge_ended)
	DialogueManager.dialogue_started.connect(_on_dialouge_started)
	
	
	
	DialogueManager.show_dialogue_balloon(load("res://scripts/dialogue.dialogue"), "game_start")
	#dialougeSpawn("you have set out on a new journey! what do you remember bringing?", "heavy load", "light load")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#hopefully checks for gameover without being buggy
	#it was buggy
	pass
	 

#start and stop player movement when dialouge
func _on_dialouge_started(resource: DialogueResource):
	$player.set_physics_process(false)
	SignalBus.goldReduction = randi_range(1, 5)

func _on_dialouge_ended(resource: DialogueResource):
	$player.set_physics_process(true)
	$hud.update_foodCounter(SignalBus.food)
	$hud.update_goldCounter(SignalBus.gold)
	
	if resource == load("res://scripts/bandit_dialouge.dialogue"):
		remove_child(hazard)
		$hud.update_foodCounter(SignalBus.food)
		$hud.update_goldCounter(SignalBus.gold)
	
#ingame event of player farry
#this is currently not set up for the player to go back from the farried location!
func _on_player_farried():
	$player.position = $ferryLocation.position
	$ferryMan.position = $newFerryGuySpot.position
	
#this works
func _on_player_hit() -> void:
	#so mobs dont spawn when ur in choice
	$hazardTimer.stop()
	#stop player movement
	#should be handled when dialouge ends
	print("uh, this should do something")
	SignalBus.goldReduction = randi_range(1, 5)
	SignalBus.foodReduction = randi_range(1,2)
	
	DialogueManager.show_dialogue_balloon(load("res://scripts/bandit_dialouge.dialogue"), "bandit_attack")
	#dialougeSpawn("oh no a bandit", "pay what they demand", "attempt escape")
	
#this also works fine
func _on_hazard_timer_timeout() -> void:
	banditSpawn()


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

func banditSpawn():
	#instance
	hazard = hazard2.instantiate()
	
	#getting spawn location (random)
	#var hazard_spawn_location = $hazardPath/hazardSpawnLocation
	#hazard_spawn_location.progress_ratio = randf()
	
	#setting spawn the marker location
	hazard.position = $banditSpawn.position
	
	##VELOCITY/MOVEMENT HANDLED IN HAZARD SCRIPT
	add_child(hazard)
	print("child added...")


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
	SignalBus.bring_to_end_screen.emit(SignalBus.food, SignalBus.gold)
	
	$player.set_physics_process(false)
	$hazardTimer.stop()
	get_tree().change_scene_to_file("res://scenes/transition_scene2.tscn")
