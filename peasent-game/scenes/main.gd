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
	$choiceWindow.updateChoices("wise choice")
	$choiceWindow/choice2.hide()
	$choiceTimer.start()

func _on_choice_window_choice_2() -> void:
	$startMenu.update_foodCounter(10)
	$choiceWindow.updateChoices("wise choice")
	$choiceWindow/choice1.hide()
	$choiceTimer.start()


func _on_choice_timer_timeout() -> void:
	pass # Replace with function body.
