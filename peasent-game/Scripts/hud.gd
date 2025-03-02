extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_foodCounter(number):
	$foodCounter.text = str("food remaining: ", number)

func update_goldCounter(number):
	$goldCounter.text = str("gold remaining: ", number)

func update_message(text):
	$gameMessage.text = str(text)
