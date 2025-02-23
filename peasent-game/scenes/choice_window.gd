extends ColorRect

signal choice1
signal choice2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func updateChoices(header, option1, option2):
	$choiceMessage.text = str(header)
	$choice1.text = str(option1)
	$choice2.text = str(option2)
	


func _on_choice_1_pressed() -> void:
	choice1.emit()
	
func _on_choice_2_pressed() -> void:
	choice2.emit()
	
