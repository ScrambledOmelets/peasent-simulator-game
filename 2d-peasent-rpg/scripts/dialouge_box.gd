extends CanvasLayer


signal choice1
signal choice2
signal choice_made

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func updateHeader(header):
	$choiceMessage.text = str(header)
	
	
func updatedChoices(option1, option2):
	$choice1.text = str(option1)
	$choice2.text = str(option2)

func newChoiceWindow():
	#show all buttons
	$choice1.show()
	$choice2.show()
	
	#show actual window
	#show()


func _on_choice_1_pressed() -> void:
	choice1.emit()
	choice_made.emit()
	$choice2.hide()

func _on_choice_2_pressed() -> void:
	choice2.emit()
	choice_made.emit()
	$choice1.hide()
