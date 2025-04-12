extends Node #must handle all game code here

@export var hazard2: PackedScene
@export var choiceWindow: PackedScene

signal gameOver
#instanced scene variables
var dialouge
var hazard
var chatting = false
var hasRained = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#spawn mobs?
	banditSpawn()
	
	#setting up game
	$player.resetPlayer($startPosition.position)
	$music_noises/travelMusic.play()
	$stormTimers/stormStart.start(randi() % 51)
	
	##checks for signals???
	SignalBus.playerHit.connect(_on_player_hit)
	SignalBus.farried.connect(_on_player_farried)
	SignalBus.unFarry.connect(_on_player_brought_back)

	#all the village entered signals going to the same function
	$villageTransition2.villageEntered.connect(_on_village_transition_village_entered)
	$villageTransition3.villageEntered.connect(_on_village_transition_village_entered)
	SignalBus.villageEnterConfirm.connect(_on_village_enter_confirm)
	
	#ok this is properly connected
	DialogueManager.dialogue_ended.connect(_on_dialouge_ended)
	DialogueManager.dialogue_started.connect(_on_dialouge_started)
	
	#begin the game
	DialogueManager.show_dialogue_balloon(load("res://scripts/dialogue.dialogue"), "game_start")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if chatting == false:
		is_game_over(SignalBus.food)

#start and stop player movement when dialouge
func _on_dialouge_started(resource: DialogueResource):
	$player.set_physics_process(false)
	SignalBus.goldReduction = randi_range(1, 5)
	$foodTimer.stop()
	chatting = true
	
	if resource == load("res://scripts/storms.dialogue"):
		$music_noises/travelMusic.stop()
		$music_noises/thunder.play()
		$music_noises/rain.play()
		#another thunder
		await get_tree().create_timer(15).timeout
		$music_noises/thunder.play()


func _on_dialouge_ended(resource: DialogueResource):
	$player.set_physics_process(true)
	$hud.update_foodCounter(SignalBus.food)
	$hud.update_goldCounter(SignalBus.gold)
	$foodTimer.start()
	chatting = false
	
	if resource == load("res://scripts/bandit_dialouge.dialogue"):
		remove_child(hazard)
		$hud.update_foodCounter(SignalBus.food)
		$hud.update_goldCounter(SignalBus.gold)
		$hazardTimer.start()
	
#ingame event of player farry
func _on_player_farried():
	$player.position = $ferryMarkers/ferryLocation.position
	$ferryMan.position = $ferryMarkers/newFerryGuySpot.position
	SignalBus.beenFarried = true

#can now go back too
func _on_player_brought_back():
	SignalBus.beenFarried = false
	$player.position = $ferryMarkers/unferryLocation.position
	$ferryMan.position = $ferryMarkers/newFerryGuySpot2.position
	

#this works
func _on_player_hit() -> void:
	#so mobs dont spawn when ur in choice
	$hazardTimer.start()
	#stop player movement
	#should be handled when dialouge ends
	print("uh, this should do something")
	SignalBus.goldReduction = randi_range(1, 5)
	SignalBus.foodReduction = randi_range(1,2)
	
	DialogueManager.show_dialogue_balloon(load("res://scripts/bandit_dialouge.dialogue"), "bandit_attack")

	
#this also works fine
func _on_hazard_timer_timeout() -> void:
	banditSpawn()


#spawning of new choice
#this also works???
func dialougeSpawn(header: String, option1: String, option2: String):
	#handle logic for each choice in different area when i start adding different types of events
	
	#instance
	dialouge = choiceWindow.instantiate()
	add_child(dialouge)
	
	#functions to update new choice
	dialouge.newChoiceWindow()
	dialouge.updateHeader(header)
	dialouge.updatedChoices(option1, option2)

func banditSpawn():
	#instance
	hazard = hazard2.instantiate()
	
	#getting spawn location (random)
	#var hazard_spawn_location = $hazardPath/hazardSpawnLocation
	#hazard_spawn_location.progress_ratio = randf()
	
	#setting spawn the marker location
	hazard.position = $banditSpawn.position
	
	##VELOCITY/MOVEMENT HANDLED IN HAZARD SCRIPT
	add_child(hazard)
	print("child added...")


func goldLogic(gold, randomNum):
	var value = "you lost " + str(randomNum) + " gold..."
	
	if gold <= 0:
		$hud.update_goldCounter(0)
		gold = 0
		$hud.update_message("oh no! you've lost all your gold...")
		dialouge.updateHeader(value)
	else:
		#update values and continue game
		$hud.update_goldCounter(gold)
	
	return value

func foodLogic(food, randomNum):
	var value = str(randomNum) + " food..."
	
	if food <= 0:
		food = 0
		$hud.update_message("you cannot continue this journey...")
		dialouge.updateHeader("you've lost all your food!")
		$hud.update_foodCounter(food)
	else:
		$hud.update_foodCounter(food)
		
	return value

func is_game_over(food):
	if food <= 0:
		food = 0
		$hud.update_foodCounter(food)
		gameOver.emit() #this works. connect signal
		print("NO FOOD")
	

#when player enters a village
func _on_village_transition_village_entered() -> void:
	DialogueManager.show_dialogue_balloon(load("res://scripts/dialogue.dialogue"), "village_confirm")


func _on_village_enter_confirm() -> void:
	pass
	$hud.update_message("Now entering a village...")
	$player.set_physics_process(false)
	
	#waiting for timer
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://scenes/transition_scene.tscn")

#when the game ends
func _on_game_over() -> void:
	$foodTimer.stop()
	$music_noises/travelMusic.stop()
	#$music/gameOverMusic.play() don't play whole music. just a sound effect - which i don't have rn
	
	
	$hud.update_message("you've run out of food...")
	$player.set_physics_process(false)
	
	await get_tree().create_timer(2).timeout
	FadingTransition.fade_transition()
	await FadingTransition.onFadeFinished
	
	get_tree().change_scene_to_file("res://scenes/transition_scene2.tscn")


func _on_food_timer_timeout() -> void:
	SignalBus.food -= 1
	$hud.update_foodCounter(SignalBus.food)


func _on_storm_start_timeout() -> void:
	if chatting == false:
		DialogueManager.show_dialogue_balloon(load("res://scripts/storms.dialogue"), "storm")
		$stormTimers/stormDuration.start()
	else:
		if not hasRained:
			$stormTimers/stormStart.start(10)


func _on_storm_duration_timeout() -> void:
	SignalBus.rainOver.emit()
	$music_noises/rain.stop()
	$music_noises/travelMusic.play()
	$hud.update_message("The storm has cleared!")
	
	#fixing player movement
	SignalBus.playerSpeedMultiplier += 0.7
	
	await get_tree().create_timer(3).timeout
	$hud.update_message("")
	hasRained = true
	
