extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$choiceWindow.hide()
	$travel.hide()
	$homescreen.show()
	$travel/HUD.hide()
	$startMenu/gameOver.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_start_menu_start_game() -> void:
	$choiceWindow.show()
	
	#var popup = choice_window.instantiate()
	#add_child(popup)


func _on_choice_window_choice_1() -> void:
	globals.food = 5
	globals.gold = 10
	
	$travel/HUD.update_foodCounter(globals.food)
	$travel/HUD.update_goldCounter(globals.gold)
	$choiceWindow/choice2.hide()
	

func _on_choice_window_choice_2() -> void:
	globals.food = 10
	globals.gold = 15
	#$startMenu.update_foodCounter(10)
	$travel/HUD.update_foodCounter(globals.food)
	$travel/HUD.update_goldCounter(globals.gold)
	$choiceWindow/choice1.hide()
	

func _on_choice_timer_timeout() -> void:
	$homescreen.hide()
	$travel.show()
	#$homescreen.texture = load("res://assets/ruins-8881488_1280.jpg")
	$choiceWindow.hide()
	#changes screen
	$travel/hazardTimer.start()
	$travel/HUD.show()

#shared choice signal for both options for ui changes
func _on_choice_window_choice_made() -> void:
	$choiceWindow.updateHeader("wise choice")
	$choiceTimer.start()


func _on_travel_game_over() -> void:
	$travel.hide()
	$travel/HUD.hide()
	$homescreen.show()
	$startMenu.gameoverText("you ran out of food or bandits killed you over gold :c")
	$startMenu/gameOver.show()
	$startMenu/startButton.text = str("play again?")
	
