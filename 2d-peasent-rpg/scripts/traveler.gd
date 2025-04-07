extends CharacterBody2D
##ok lets just scrap this lmo

var inChat1 = false
var inRange1 = false
@export var speed = 100
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var animation_list
var sprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$toolTip.hide()
	DialogueManager.dialogue_ended.connect(_on_dialouge_ended)
	animation_list = ["death_guy", "flower_person"]
	sprite = animation_list.pick_random()
	animated_sprite_2d.play(sprite)
	

func _physics_process(delta: float) -> void:
	#want to move when player not in range
	velocity = Vector2.LEFT
	move_and_slide()
	
	#if in range, then stop moving
	if inRange1 == true:
		velocity = Vector2.ZERO
		#var direction = (SignalBus.player_location - global_position).normalized()		
		#if position.distance_to(SignalBus.player_location) > 50:
			#velocity = position.direction_to(SignalBus.player_location) * speed
			
			
	
	
	
	
	#sprite animation
	if velocity.length() > 0:
		#should get running animation
		animated_sprite_2d.play(sprite + "R")
	else:
		animated_sprite_2d.play(sprite)
	#sprite animation direction
	if velocity.x < 0:
		#if walk left, then flip sprite to turn left
		$AnimatedSprite2D.flip_h = true
	elif velocity.x > 0:
		$AnimatedSprite2D.flip_h = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#speaking logic
	if Input.is_action_just_pressed("ui_accept") and inChat1 == false and inRange1 == true:
		$toolTip.hide()
		DialogueManager.show_dialogue_balloon(load("res://scripts/beggar_scene.dialogue"), "beggar_speak")
		inChat1 = true
		
func _on_dialouge_ended(resource: DialogueResource):
	inChat1 = false
	

func _on_conversation_range_body_entered(body: Node2D) -> void:
	$toolTip.show()
	inRange1  = true
	

func _on_conversation_range_body_exited(body: Node2D) -> void:
	$toolTip.hide()
	inRange1 = false
