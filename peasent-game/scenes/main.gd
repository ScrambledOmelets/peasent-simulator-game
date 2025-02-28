extends Node

#@export var choice_window: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$choiceWindow.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_start_menu_start_game() -> void:
	$choiceWindow.show()
	
	
	#var popup = choice_window.instantiate()
	#add_child(popup)


func _on_choice_window_choice_1() -> void:
	$startMenu.update_foodCounter(5)
	$choiceWindow/choice2.hide()
	

func _on_choice_window_choice_2() -> void:
	$startMenu.update_foodCounter(10)
	$choiceWindow/choice1.hide()
	


func _on_choice_timer_timeout() -> void:
	$homescreen.hide()
	$travel.show()
	#$homescreen.texture = load("res://assets/ruins-8881488_1280.jpg")
	$choiceWindow.hide()
	#changes screen

#shared choice signal for both options for ui changes
func _on_choice_window_choice_made() -> void:
	$choiceWindow.updateChoices("wise choice")
	$choiceTimer.start()
