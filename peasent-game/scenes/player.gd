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
	
	
	move_and_slide()
		
