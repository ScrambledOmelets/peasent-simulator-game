extends CharacterBody2D
##add velocity logic and stuff
#make custom key mapping in project settings

const SPEED = 200
const JUMP_VELOCITY = -500
signal hazard_hit

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
		
	
	#input direction obtaining
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
	
	#actually detecting collision
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		#converting class of collider var
		var hazard1 : Hazard1 = collider as Hazard1
		
		if collider.is_in_group("hazard1"):
			print("you hit the hazard!!")
		
		#need to detect collision only once
		##extra logic testing
		#if hazard1:
			#print("collider as Hazard1")
		
	
	
		
