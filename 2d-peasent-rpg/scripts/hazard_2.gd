extends Area2D
#signal playerHit
@export var speed = 500


func _ready() -> void:
	$AnimatedSprite2D.play("coin")
	

func _process(delta: float) -> void:
	#wtf this is so simple and it makes the object follow the player
	var direction = (SignalBus.player_location - global_position).normalized()
	position += speed * direction * delta 
	
	
	###updates position each frame
	#
	



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		SignalBus.playerHit.emit()
		print("they hit")
