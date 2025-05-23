extends CanvasLayer
@onready var color_rect: ColorRect = $ColorRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer

signal onFadeFinished

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#so that it doesnt grab attention
	color_rect.visible = false
	SignalBus.rainOver.connect(_onRainOver)

#custom transition function
func fade_transition():
	color_rect.visible = true
	animation_player.play("fade_to_black")

func rain_color():
	pass
	color_rect.visible = true
	animation_player.play("rain")

func _onRainOver():
	animation_player.play("rain_end")
	await animation_player.animation_finished
	color_rect.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_to_black":
		onFadeFinished.emit()
		animation_player.play("fade_to_normal")
	elif anim_name == "fade_to_normal":
		color_rect.visible = false
		
		
