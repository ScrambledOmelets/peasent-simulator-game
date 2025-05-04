extends CharacterBody2D

var inChat1 = false
var inRange1 = false
@export var speed = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$toolTip.hide()
	DialogueManager.dialogue_ended.connect(_on_dialouge_ended)
	$AnimatedSprite2D.play("standing")
	SignalBus.beggarsFavor = false
	SignalBus.metBeggar = false
	SignalBus.gaveGift = false

func _physics_process(delta: float) -> void:	
	if SignalBus.metBeggar and not SignalBus.beggarsFavor:
		velocity = Vector2.ZERO
		$AnimatedSprite2D.play("standing")
	elif SignalBus.metBeggar and SignalBus.gaveGift:
		velocity = Vector2.ZERO
		$AnimatedSprite2D.play("standing")
		#look at player
		if position.direction_to(SignalBus.player_location).x < 0:
			$AnimatedSprite2D.flip_h = true
		elif position.direction_to(SignalBus.player_location).x > 0:
			$AnimatedSprite2D.flip_h = false
	else:
		#if in range, then calculate distance between player and beggar
		#if that distance is greater than 5, then approach player
		#else, then don't move
		if inRange1 == true:
			#var direction = (SignalBus.player_location - global_position).normalized()		
			if position.distance_to(SignalBus.player_location) > 50:
				velocity = position.direction_to(SignalBus.player_location) * speed
				move_and_slide()
				$AnimatedSprite2D.play("running")
				
			else:
				$AnimatedSprite2D.play("standing")
					#sprite animation. it works not
				#if position.distance_to(SignalBus.player_location) > 50: ## i dont think this ever goes below zero
					#
					#print(velocity)
					#print(str(velocity.length()) + "the length")
		else:
			$AnimatedSprite2D.play("standing")
			print("did u stop walking")
			#sprite animation direction
		if velocity.x < 0:
			#if walk left, then flip sprite to turn left
			$AnimatedSprite2D.flip_h = true
		elif velocity.x > 0:
			$AnimatedSprite2D.flip_h = false
	
	#don't move if none of above conditinos are met
	velocity = Vector2.ZERO
	
	
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#speaking logic
	if Input.is_action_just_pressed("interact") and inChat1 == false and inRange1 == true:
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
