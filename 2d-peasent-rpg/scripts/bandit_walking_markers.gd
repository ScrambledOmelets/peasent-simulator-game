extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	SignalBus.marker1 = $banditWalk1.global_position
	SignalBus.marker2 = $banditWalk2.global_position
	SignalBus.marker3 = $banditWalk3.global_position
