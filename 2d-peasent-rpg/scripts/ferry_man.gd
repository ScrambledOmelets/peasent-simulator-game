extends CharacterBody2D

var inChat = false
var inRange = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$toolTip.hide()
	DialogueManager.dialogue_ended.connect(_on_dialouge_ended)
	$AnimatedSprite2D.play("standing")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and inChat == false and inRange == true:
		$toolTip.hide()
		DialogueManager.show_dialogue_balloon(load("res://scripts/dialogue.dialogue"), "ferry_man")
		inChat = true
		
	#direction turning
	if position.direction_to(SignalBus.player_location).x < 0:
		$AnimatedSprite2D.flip_h = true
	elif position.direction_to(SignalBus.player_location).x > 0:
		$AnimatedSprite2D.flip_h = false
		
func _on_dialouge_ended(resource: DialogueResource):
	inChat = false
	

func _on_conversation_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("this is detecting the other enter signal")
		$toolTip.show()
		inRange  = true
	

func _on_conversation_range_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("exiting ferry body too")
		$toolTip.hide()
		inRange = false
