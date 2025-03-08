extends Area2D
signal playerHit

func _ready() -> void:
	$AnimatedSprite2D.play("default")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		playerHit.emit()
