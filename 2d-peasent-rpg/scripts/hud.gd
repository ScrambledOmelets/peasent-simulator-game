extends CanvasLayer

@export var foodBar : PackedScene
@export var goldBar : PackedScene
@onready var food_row: HBoxContainer = $foodRow
@onready var gold_row: HBoxContainer = $goldRow
@onready var game_message: Label = $gameMessage
@onready var bar_shake: AnimationPlayer = $barShake

var startingFood
var StartingGold

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.startingAmounts.connect(_onGameStart)
	game_message.hide()

#sets max amt of food and gold icons
#this works
func _onGameStart(food, gold):
	startingFood = food
	StartingGold = gold
	
	setMaxFood(food)
	setMaxGold(gold)

func setMaxFood(max : int):
	for i in range(max):
		var oneFood = foodBar.instantiate()
		food_row.add_child(oneFood)
		
func setMaxGold(max : int):
	for i in range(max):
		var oneGold = goldBar.instantiate()
		gold_row.add_child(oneGold)

#this works fine now
func update_foodCounter(number):
	var foods = food_row.get_children()
	var hasChanged = false
	
	#should hopefully add more if you go over the amount
	if number > foods.size():
		setMaxFood(number - foods.size())
		#needs this line to reupdate the list
		foods = food_row.get_children()
	
	if number != (foods.size() - number):
		hasChanged = true
	
	#should update all the food to be normal colored
	for i in range(number):
		foods[i].update(true)
	
	#updates the food between current value and max value to be grey
	for i in range(number, foods.size()):
		foods[i].update(false)
	#hopefully animates
	#it works!
	playAnim("food_shake")

func update_goldCounter(number):
	var golds = gold_row.get_children()
	var hasChanged = false
	
	if number > golds.size():
		setMaxGold(number - golds.size())
		golds = gold_row.get_children()
	
	if number != (golds.size() - number):
		hasChanged = true
	
	for i in range(number):
		golds[i].update(true)
		
	for i in range(number, golds.size()):
		golds[i].update(false)
	
	if hasChanged: playAnim("gold_shake")

func update_message(text):
	game_message.show()
	game_message.text = str(text)
	await get_tree().create_timer(3).timeout
	game_message.hide()

#plays animations forwards and backwards for the shaek effect
func playAnim(name):
	bar_shake.play(name)
	await bar_shake.animation_finished
	bar_shake.play_backwards(name)
	
