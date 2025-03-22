extends CharacterBody2D

var inChat = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$toolTip.hide()
	DialogueManager.dialogue_ended.connect(_on_dialouge_ended)
	$AnimatedSprite2D.play("standing")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") and inChat == false:
		$toolTip.hide()
		DialogueManager.show_dialogue_balloon(load("res://scripts/dialogue.dialogue"), "ferry_man")
		inChat = true
		
		
func _on_dialouge_ended(resource: DialogueResource):
	inChat = false

func _on_conversation_range_body_entered(body: Node2D) -> void:
	$toolTip.show()

func _on_conversation_range_body_exited(body: Node2D) -> void:
	$toolTip.hide()
