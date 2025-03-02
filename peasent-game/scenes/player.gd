extends CharacterBody2D
##add velocity logic and stuff
#make custom key mapping in project settings

const SPEED = 200
const JUMP_VELOCITY = -500
signal hazard_hit

#logic for signal firing
var should_emit = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play()
	print(str(should_emit))
	
	
func resetPlayer(pos):
	position = pos
	should_emit = false


func signalEmit():
	while should_emit == true:
		print(str(should_emit))
		hazard_hit.emit()
		print("signal emitted!")
		should_emit = false

#func _process(delta: float) -> void:
	#var cooldown = 2
	#
	#if cooldown > 0:
		#cooldown -= delta
	#elif cooldown == 0 and should_emit == true:
		#hazard_hit.emit()
		#print("signal emitted!")
		#cooldown = 2
	#
	#hopefully fires signal once
	#if should_emit == true:
		#hazard_hit.emit()
		#print("signal emitted!")



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
		
		#await get_tree().create_timer(1.0).timeout
		if collider.is_in_group("hazard1"):
			should_emit = true
			signalEmit()
			print("you hit the hazard!!")
			
	#
		
		#need to detect collision only once
		##extra logic testing
		#if hazard1:
			#print("collider as Hazard1")


#func _on_player_observer_body_entered(body: Node2D) -> void:
	#if body.is_in_group("hazard1"):
		#print("youve been hit!")
