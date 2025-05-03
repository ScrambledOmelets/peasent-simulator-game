extends Panel

@onready var animated_sprite: AnimatedSprite2D = $animatedSprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	spin()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update(whole : bool):
	if whole: animated_sprite.animation = "base"
	else: animated_sprite.animation = "used"

func spin():
	animated_sprite.play("umm")
	await animated_sprite.animation_finished
	animated_sprite.stop()
