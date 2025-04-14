extends Area2D

##made village entered variable global
@export var village_number : int
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		SignalBus.villageEntered.emit(village_number)
