extends Area2D
#signal playerHit
@export var speed = 500

func _ready() -> void:
	$AnimatedSprite2D.play("default")
	look_at(SignalBus.player_location)

func _process(delta: float) -> void:
	pass
	#var v  = Vector2.ZERO
	
	
	###updates position each frame
	#
	

func _physics_process(delta: float) -> void:
	pass
	var velocity = Vector2.ZERO
	var dir = (SignalBus.player_location - global_position).normalized()
	velocity = transform.x * dir * speed
	position += velocity * delta


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		SignalBus.playerHit.emit()
		print("they hit")
