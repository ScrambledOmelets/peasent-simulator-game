extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$music.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_restart_button_pressed() -> void:
	$sfx.play()
	FadingTransition.fade_transition()
	await FadingTransition.onFadeFinished
	get_tree().change_scene_to_file("res://scenes/main.tscn")
