extends CharacterBody2D

var speed = 300

#funny movement from tutorial thing
#func player_input() -> void:
	#if Input.is_action_just_pressed("move_right"):
		#velocity = Vector2.RIGHT
	#elif Input.is_action_just_pressed("move_up"):
		#velocity = Vector2.UP
	#elif Input.is_action_just_pressed("move_left"):
		#velocity = Vector2.LEFT
	#elif Input.is_action_just_pressed("move_down"):
		#velocity = Vector2.DOWN
		#


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("standing")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var v  = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		v.x += 1
	if Input.is_action_pressed("move_left"):
		v.x -= 1
	if Input.is_action_pressed("move_down"):
		v.y += 1
	if Input.is_action_pressed("move_up"):
		v.y -= 1

	#sprite animation
	#idk if any of these work yet but this is a issue for another time
	if v.length() > 0:
		v = v.normalized() * speed
		$AnimatedSprite2D.play("running")
	else:
		$AnimatedSprite2D.play("standing")
		
	#sprite animation direction
	if v.x < 0:
		#if walk left, then flip sprite to turn left
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false
		
