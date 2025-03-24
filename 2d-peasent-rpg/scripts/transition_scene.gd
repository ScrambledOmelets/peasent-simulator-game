extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$hud.update_foodCounter(SignalBus.food)
	$hud.update_goldCounter(SignalBus.gold)
	DialogueManager.show_dialogue_balloon(load("res://scripts/village.dialogue"), "village_entrance")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$hud.update_foodCounter(SignalBus.food)
	$hud.update_goldCounter(SignalBus.gold)



func _from_gameover(foodAmount, goldAmount):
	print("game hs been lost")
	$Label.text = str("you were forced to turn back home with " + goldAmount + " gold and " + foodAmount + " food" + "\n" + "will you begin another journey?")
	


func _on_nopeout_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
