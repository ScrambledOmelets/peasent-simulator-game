extends Node
#holds all signals..

#village signals
signal villageEntered(village)
signal leftVillage(case : String)
signal villageEnterConfirm
signal dayEnded
signal currentLocation(location : String)

#game signals
signal farried
signal unFarry

#game setup signal
signal startingAmounts(food, gold)

#hazard signal
signal playerHit

#rain signal
signal rainOver

#player global variable
var player_location : Vector2

#walking marker global positions
var marker1
var marker2
var marker3

#game variables
var gold : int
var food : int 
var luck : int
var goldReduction :int
var foodReduction : int
##collects how much gold you make in the village
var goldGrowth : int
var daysInVillage : int
var soldEverything : bool

#rain variable
var hideInRain : bool = false

#60% for true 
func randomizer():
	var value
	var ranNum = randi() % 101
	if ranNum >= 30:
		value = true
	##this might break my current logic
	#elif ranNum < 59 and ranNum > 20:
		#value = 1
	else:
		value = false
	print(ranNum)
	return value


#character variables
var metBeggar : bool
var beggarsFavor : bool
var gaveGift : bool
var beenFarried : bool = false
var playerSpeedMultiplier : float

#village variables
var hasExplored : bool = false
var whichVillageEntered : int

#music variables
var negSound : AudioStreamPlayer
var posSound : AudioStreamPlayer

#music function
func playSound(sound : AudioStreamPlayer):
	sound.play()
