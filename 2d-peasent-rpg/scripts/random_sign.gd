extends Area2D

func _ready() -> void:
	$helperText.hide()

func _on_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
	if body.is_in_group("player"):
		$helperText.show()




func _on_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
	if body.is_in_group("player"):
		$helperText.hide()
