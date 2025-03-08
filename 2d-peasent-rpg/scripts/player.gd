extends CharacterBody2D

@export var speed = 300

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
func resetPlayer(pos):
	position = pos

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("standing")

#from godot documentation for player movement
func get_input():
	var input_direction = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = input_direction * speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()
	
	#get player position
	SignalBus.player_location = position
	
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
	
		
