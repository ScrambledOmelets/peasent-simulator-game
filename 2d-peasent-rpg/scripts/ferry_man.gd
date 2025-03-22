extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$toolTip.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_conversation_range_body_entered(body: Node2D) -> void:
	pass # Replace with function body.


func _on_conversation_range_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
