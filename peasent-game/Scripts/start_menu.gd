extends CanvasLayer
signal start_game

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#$foodCounter.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func gameoverText(text):
	$gameOver.text = str(text)


func _on_start_button_pressed() -> void:
	$startButton.hide()
	$title.hide()
	#$foodCounter.show()
	start_game.emit()
