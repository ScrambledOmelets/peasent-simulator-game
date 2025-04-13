extends Node
@onready var moosic: AudioStreamPlayer2D = $moosic
@onready var background: TextureRect = $background
@onready var game_text: Label = $background/gameText
@onready var nopeout_button: Button = $nopeoutButton
@onready var game_over_music: AudioStreamPlayer2D = $"game-over-music"

var startingImage
var currentImage
var imageList = ["res://assets/painted-village.png", "res://assets/the-fete-at-bermondsey.png"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	moosic.play()
	$hud.update_foodCounter(SignalBus.food)
	$hud.update_goldCounter(SignalBus.gold)
	#setting background
	startingImage = imageList[randi() % imageList.size()]
	background.texture = load(startingImage)
	#print(startingImage)
	
	game_text.hide()
	nopeout_button.hide()
	DialogueManager.show_dialogue_balloon(load("res://scripts/village.dialogue"), "village_entrance")
	
	#connecting signals
	SignalBus.dayEnded.connect(_on_day_ended)
	SignalBus.leftVillage.connect(_on_village_left)
	SignalBus.currentLocation.connect(_on_scene_change)
	
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
			game_text.text = str("You sold everything and return home with " + str(SignalBus.gold) + " gold.")
		"plague_leave":
			game_text.text = str("You managed to escape the plague. But you didn't sell anything.")
		"escape_sickness":
			game_text.text = str("You didn't sell anything, all your produce is gone, but you helped people.")
		"dead":
			game_text.text = str("You died from plague...")
			game_over_music.play()
		"no_gold":
			game_text.text = str("You return home empty handed...")
			game_over_music.play()
		_:
			game_text.text = str("something happened. good job or sorry that happened.")

func _on_scene_change(location):
	match location:
		"normal":
			#ensures that the image is consistent the entire time
			#despite being randomized at first
			background.texture = load(startingImage)
			
		"plague": #if map has plague, it should change to this
			background.texture = load("res://assets/destroyed-village.jpg")
		
	
func _on_nopeout_button_pressed() -> void:
	$sfx.play()
	FadingTransition.fade_transition()
	await FadingTransition.onFadeFinished
	get_tree().change_scene_to_file("res://scenes/main.tscn")
