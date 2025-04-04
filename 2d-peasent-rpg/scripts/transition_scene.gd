extends Node
@onready var moosic: AudioStreamPlayer2D = $moosic
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var game_text: Label = $Sprite2D/gameText
@onready var nopeout_button: Button = $nopeoutButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	moosic.play()
	$hud.update_foodCounter(SignalBus.food)
	$hud.update_goldCounter(SignalBus.gold)
	game_text.hide()
	nopeout_button.hide()
	DialogueManager.show_dialogue_balloon(load("res://scripts/village.dialogue"), "village_entrance")
	
	SignalBus.dayEnded.connect(_on_day_ended)
	SignalBus.leftVillage.connect(_on_village_left)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$hud.update_foodCounter(SignalBus.food)
	$hud.update_goldCounter(SignalBus.gold)


func _on_day_ended():
	SignalBus.daysInVillage += 1
	SignalBus.randomizer()

func _on_village_left(case):
	$hud.hide()
	##glitchy and i dont have the time to fix it
	#sprite_2d.texture = load("res://assets/ruins-8881488_1280.jpg")
	moosic.stop()
	game_text.show()
	nopeout_button.show()
	
	match case:
		"normal_leave":
			game_text.text = str("You've left the village and returned home with " + str(SignalBus.gold) + " gold." + "\n" + "Your journey was sucessful.")
		"sold_everything":
			game_text.text = str("You sold everything!!! Wahoo!! You beat the game.")
		"plague_leave":
			game_text.text = str("You managed to escape the plague. But you didn't sell anything.")
		"escape_sickness":
			game_text.text = str("You didn't sell anything but all your produce is gone, so you return home with nothing to show for your trip.")
		"dead":
			game_text.text = str("You died from plague...")
		_:
			game_text.text = str("something happened. good job or sorry that happened.")


	
func _on_nopeout_button_pressed() -> void:
	$sfx.play()
	await $sfx.finished
	get_tree().change_scene_to_file("res://scenes/main.tscn")
