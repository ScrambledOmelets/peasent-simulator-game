extends CharacterBody2D
##add velocity logic and stuff
#make custom key mapping in project settings

const SPEED = 50
const JUMP_VELOCITY = -300

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	#gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	#jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		print("hi")
	
	#input direction obtaining
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
		
