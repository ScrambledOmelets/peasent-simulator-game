extends Panel

@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update(whole : bool):
	if whole: sprite_2d.animation = "base"
	else: sprite_2d.animation = "used"
