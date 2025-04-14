extends Node
#holds all signals..

#village signals
signal leftVillage(case : String)
signal villageEnterConfirm
signal dayEnded
signal currentLocation(location : String)

#game signals
signal farried
signal unFarry

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
var daysInVillage : int
var soldEverything : bool

#var repurposed
var hideInRain : bool = false

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

#music variables
var negSound : AudioStreamPlayer
var posSound : AudioStreamPlayer

#music function
func playSound(sound : AudioStreamPlayer):
	sound.play()
