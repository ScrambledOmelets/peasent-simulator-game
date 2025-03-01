extends Node
@export var hazard1: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_hazard_timer_timeout() -> void:
	#instance
	var hazard = hazard1.instantiate()
	
	#getting spawn location (random)
	var hazard_spawn_location = $hazardPath/hazardSpawnLocation
	hazard_spawn_location.progress_ratio = randf()
	
	#perpendicular angling?
	var direction = hazard_spawn_location.rotation + PI/2
	
	#setting spawn to random
	hazard.position = hazard_spawn_location.position
	
	#setting velocity
	var velocity = Vector2(200, 0.0)
	hazard.linear_velocity = velocity.rotated(direction)
	
	#add instance as child
	add_child(hazard)
	
