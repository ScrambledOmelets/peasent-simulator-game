extends Area2D
#signal playerHit
@export var speed = 500

var playerPresent = false

func _ready() -> void:
	$AnimatedSprite2D.play("standing")
	

func _process(delta: float) -> void:
	#wtf this is so simple and it makes the object follow the player
	if playerPresent == true:
		var direction = (SignalBus.player_location - global_position).normalized()
		position += speed * direction * delta 
	else:
		pass
	

#signal works too
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		SignalBus.playerHit.emit()
		print("they hit")
		#disable movement
		set_physics_process(false)


func _on_player_in_range_body_entered(body: Node2D) -> void:
	pass # Replace with function body.


func _on_player_in_range_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
