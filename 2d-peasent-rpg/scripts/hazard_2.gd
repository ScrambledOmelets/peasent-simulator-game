extends Area2D
#signal playerHit
@export var speed = 100

var velocity
var playerPresent = false
var walkPointList

func _ready() -> void:
	$AnimatedSprite2D.play("standing")
	

func _process(delta: float) -> void:
	#i wanna make it so that he kind of patrolls around
	#if player in range it will follow them
	if playerPresent == true:
		var direction = (SignalBus.player_location - global_position).normalized()
		velocity = speed * direction * delta 
		position += velocity
		
	else:
		walkPointList = [SignalBus.marker1, SignalBus.marker2, SignalBus.marker3]
		var ranPoint = walkPointList.pick_random()
		var direction = (ranPoint - global_position).normalized()
		
		velocity = speed * direction * delta
		position += velocity
		
		#bro looks so glitchy lmao
		if ranPoint == global_position:
			await get_tree().create_timer(2).timeout
			ranPoint = walkPointList.pick_random()
			velocity = speed * direction * delta
			position += velocity
		else:
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
