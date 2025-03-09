extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.bring_to_end_screen.connect(_from_gameover)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_restart_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _from_gameover(foodAmount, goldAmount):
	print("game hs been lost")
	$Label.text = str("you were forced to turn back home with " + goldAmount + " gold and " + foodAmount + " food" + "\n" + "will you begin another journey?")
	
