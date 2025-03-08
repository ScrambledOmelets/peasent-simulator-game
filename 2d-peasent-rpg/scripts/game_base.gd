extends Node

@export var hazard1: PackedScene
@export var hazard2: PackedScene
@export var choiceWindow: PackedScene

var dialouge
var hazard
#must handle all game code here
#pause player scene when choices on screen

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$player.resetPlayer($startPosition.position)
	$hud.update_message("")
	#checks for signals???
	SignalBus.playerHit.connect(_on_player_hit)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#this works
func _on_player_hit() -> void:
	pass
	print("signal recieved")
	
#this doesnt always work??????
#only spawns hazards like every other time????
func _on_hazard_timer_timeout() -> void:
	#instance
	hazard = hazard2.instantiate()
	
	#getting spawn location (random)
	var hazard_spawn_location = $hazardPath/hazardSpawnLocation
	hazard_spawn_location.progress_ratio = randf()
	
	#perpendicular angling???
	var direction = hazard_spawn_location.rotation + PI/2
	
	#setting spawn to random
	hazard.position = hazard_spawn_location.position
	
	#var velocity = Vector2(200, 0.0)
	#hazard.linear_velocity = velocity.rotated(direction)
	
	#hopefully this makes the thing move to the player
	#var dir = ($player.global_position - hazard.position).normalized()
	#
	##setting velocity
	#var velocity = Vector2(500, 0.0)
	#hazard.position += velocity * dir
	#
	#add instance as child
	add_child(hazard)
	print("child added...")


#spawning of new choice
func dialougeSpawn(header: String, option1: String, option2: String):
	#handle logic for each choice in different area when i start adding different types of events
	
	#instance
	dialouge = choiceWindow.instantiate()
	add_child(dialouge)
	
	#functions to update new choice
	dialouge.newChoiceWindow()
	dialouge.updateHeader(header)
	dialouge.updatedChoices(option1, option2)
