extends Node

#homescreen is set to the main scene
#need to set up to change scenes with get_tree().change_scene_to_file() or something
	#scene change from homescreen to the game scene
	#then change back again at the end
#main file will handle backend code so it cant be main scene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$moosic.play(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_homescreen_start() -> void:
	
	get_tree().change_scene_to_file("res://scenes/game_base.tscn")
