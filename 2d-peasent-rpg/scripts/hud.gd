extends CanvasLayer

@export var foodBar : PackedScene
@export var goldBar : PackedScene
@onready var food_row: HBoxContainer = $foodRow
@onready var gold_row: HBoxContainer = $goldRow

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.startingAmounts.connect(_onGameStart)
	$gameMessage.text = str("")

#sets max amt of food and gold icons
func _onGameStart(food, gold):
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

func update_foodCounter(number):
	$foodCounter.text = str("food remaining: ", number)

func update_goldCounter(number):
	$goldCounter.text = str("gold remaining: ", number)

func update_message(text):
	$gameMessage.text = str(text)
