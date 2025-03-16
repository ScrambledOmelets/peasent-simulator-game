extends Area2D

signal villageEntered

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		villageEntered.emit()
