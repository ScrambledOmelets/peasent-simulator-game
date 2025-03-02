extends Node
@export var hazard1: PackedScene
#@export var main : Main



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$choiceWindow.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_hazard_timer_timeout() -> void:
	#instance
	var hazard = hazard1.instantiate()
	
	#getting spawn location (random)
	var hazard_spawn_location = $hazardPath/hazardSpawnLocation
	hazard_spawn_location.progress_ratio = randf()
	
	#perpendicular angling?
	var direction = hazard_spawn_location.rotation + PI/2
	
	#setting spawn to random
	hazard.position = hazard_spawn_location.position
	
	#setting velocity
	var velocity = Vector2(500, 0.0)
	hazard.linear_velocity = velocity.rotated(direction)
	
	#add instance as child
	add_child(hazard)

func _on_player_hazard_hit() -> void:
	#so mobs dont spawn when ur in choice
	$hazardTimer.stop()
	
	$choiceWindow.show()
	$choiceWindow.updateHeader("oh no a bandit!")
	$choiceWindow.updatedChoices("pay the price", "attempt escape")
	
	

func _on_choice_window_choice_1() -> void:
	var num = randi_range(1, 5)
	globals.gold -= num
	if globals.gold == 0:
		$HUD.update_goldCounter(globals.gold)
		$choiceWindow.updateHeader("you've lost all your gold...")
	else:
		$HUD.update_goldCounter(globals.gold)
		var value = "you lost" + str(num) + "gold..."
		$choiceWindow.updateHeader(value) 
