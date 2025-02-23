extends CanvasLayer
signal start_game

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$foodCounter.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_foodCounter(number):
	$foodCounter.text = str("food remaining: ", number)


func _on_start_button_pressed() -> void:
	$startButton.hide()
	$title.hide()
	$foodCounter.show()
	start_game.emit()
