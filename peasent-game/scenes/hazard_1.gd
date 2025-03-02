extends RigidBody2D
class_name Hazard1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.set_flip_h(true)
	$AnimatedSprite2D.play("default")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		#makes it frozen!!
		set_deferred("freeze", true)
		print("frozen???")
		
		#disables hazard's collision shape
		$CollisionShape2D.set_deferred("disabled", true) #shouldn't fal through ground now bc its frozen
		
	
