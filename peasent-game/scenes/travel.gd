extends Node
@export var hazard1: PackedScene

signal gameOver
var hazard

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$choiceWindow.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_hazard_timer_timeout() -> void:
	#instance
	hazard = hazard1.instantiate()
	
	#getting spawn location (random)
	var hazard_spawn_location = $hazardPath/hazardSpawnLocation
	hazard_spawn_location.progress_ratio = randf()
	
	#perpendicular angling?
	var direction = hazard_spawn_location.rotation + PI/2
	
	#setting spawn to random
	hazard.position = hazard_spawn_location.position
	
	#setting velocity
	var velocity = Vector2(500, 0.0)
	hazard.linear_velocity = velocity.rotated(direction)
	
	#add instance as child
	add_child(hazard)

func _on_player_hazard_hit() -> void:
	#so mobs dont spawn when ur in choice
	$hazardTimer.stop()
	
	$choiceWindow.newChoiceWindow()
	$choiceWindow.updateHeader("oh no a bandit!")
	$choiceWindow.updatedChoices("pay the price", "attempt escape")
	
	
func _on_choice_window_choice_1() -> void:
	#button hide
	$choiceWindow/choice2.hide()
	#gen random number
	var num = randi_range(1, 5)
	
	#subtract from gold amt bc bandits
	globals.gold -= num
	
	is_game_over(globals.food, globals.gold)
	#logic for gold
	$choiceWindow.updateHeader(goldLogic(globals.gold, num))

func _on_choice_window_choice_2() -> void:
	#hide button
	$choiceWindow/choice1.hide()
	var num1 = randi_range(1, 5)
	var num2 = randi_range(1,3)
	globals.gold -= num1
	globals.food -= num2
	
	is_game_over(globals.food, globals.gold)
	#should update everything and return the value string to update header
	#wtf me when the code works (im shocked and surprised)
	$choiceWindow.updateHeader(goldLogic(globals.gold, num1) + foodLogic(globals.food, num2) + " while escaping")
		
	
func _on_choice_window_choice_made() -> void:
	$textTimer.start()
	await $textTimer.timeout
	
	#checking if gameover?
	#it works, good position
	#is_game_over(globals.food)
	
	#wow this works!!!
	remove_child(hazard)
	$hazardTimer.start()
	$choiceWindow.hide()
	$Player.resetPlayer($startPosition.position)
	
	
func goldLogic(gold, randomNum):
	var value = "you lost " + str(randomNum) + " gold..."
	
	if gold <= 0:
		$HUD.update_goldCounter(0)
		gold = 0
		$HUD.update_message("oh no! you've lost all your gold...")
		$choiceWindow.updateHeader(value)
	else:
		#update values and continue game
		$HUD.update_goldCounter(gold)
	
	return value

func foodLogic(food, randomNum):
	var value = str(randomNum) + " food..."
	
	if food <= 0:
		#emit gameover signal and handle the function in main
		$HUD.update_message("you cannot continue this journey...")
		$choiceWindow.updateHeader("you've lost all your food!")
		$HUD.update_foodCounter(0)
	else:
		$HUD.update_foodCounter(food)
		
	return value
#create function to check if food is completely depleted
#if yes, then end the game
#check if you alr have 0 gold when you have bandit event. if it is neg number, and bandits attack, game over
func is_game_over(food, gold):
	if food <= 0:
		$textTimer.start()
		await $textTimer.timeout
		gameOver.emit() #this works. connect signal
		print("NO FOOD")
	elif gold < 0:
		$textTimer.start()
		await $textTimer.timeout
		gameOver.emit()
		print("RAN OUT OF GOLD")
