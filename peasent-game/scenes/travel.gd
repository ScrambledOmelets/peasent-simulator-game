extends Node
@export var hazard1: PackedScene
#@export var main : Main

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
	
	#logic to see if its game over
	if globals.gold == 0:
		$HUD.update_goldCounter(globals.gold)
		$choiceWindow.updateHeader("you've lost all your gold...")
	else:
		#update values and continue game
		$HUD.update_goldCounter(globals.gold)
		var value = "you lost " + str(num) + " gold..."
		$choiceWindow.updateHeader(value) 

func _on_choice_window_choice_2() -> void:
	#hide button
	$choiceWindow/choice1.hide()
	var num1 = randi_range(1, 5)
	var num2 = randi_range(1,3)
	globals.gold -= num1
	globals.food -= num2
	
	#this could probably be made into a function but im tired and dgaf rn
	if globals.gold == 0:
		$HUD.update_goldCounter(globals.gold)
		$choiceWindow.updateHeader("you've lost all your gold...")
	else:
		$HUD.update_goldCounter(globals.gold)
		
	if globals.food == 0:
		$choiceWindow.updateHeader("you've lost all your food and cannot continue...")
		$HUD.update_foodCounter(globals.food)
	else:
		$HUD.update_goldCounter(globals.gold)
		$HUD.update_foodCounter(globals.food)
		var value = "you lost " + str(num1) + " gold and " + str(num2) + " food escaping"
		$choiceWindow.updateHeader(value)
	


func _on_choice_window_choice_made() -> void:
	$textTimer.start()
	await $textTimer.timeout
	
	#wow this works!!!
	remove_child(hazard)
	$hazardTimer.start()
	$choiceWindow.hide()
	$Player.resetPlayer($startPosition.position)
	
	
#create function to check if food is completely depleted
#if yes, then end the game
