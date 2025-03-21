extends Area2D
#signal playerHit
@export var speed = 500

var velocity
var playerPresent = false

func _ready() -> void:
	$AnimatedSprite2D.play("standing")
	

func _process(delta: float) -> void:
	#if player in range it will follow them
	if playerPresent == true:
		var direction = (SignalBus.player_location - global_position).normalized()
		velocity = speed * direction * delta 
		position += velocity
		
		#sprite animation
		if velocity.length() > 0:
			$AnimatedSprite2D.play("running")
		else:
			$AnimatedSprite2D.play("standing")
			
		#sprite animation direction
		if velocity.x < 0:
			#if walk left, then flip sprite to turn left
			$AnimatedSprite2D.flip_h = true
		elif velocity.x > 0:
			$AnimatedSprite2D.flip_h = false
	else:
		velocity = 0
		position += velocity
		$AnimatedSprite2D.play("standing")
	

#signal works too
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		SignalBus.playerHit.emit()
		print("they hit")
		#disable movement
		set_physics_process(false)


func _on_player_in_range_body_entered(body: Node2D) -> void:
	playerPresent = true

func _on_player_in_range_body_exited(body: Node2D) -> void:
	playerPresent = false
