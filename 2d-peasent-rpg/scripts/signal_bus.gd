extends Node
#holds all signals..

#village signals
signal leftVillage
signal villageEnterConfirm

#game signals
signal farried
signal unFarry

#hazard signal
signal playerHit

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

#character variables
var metBeggar : bool
var beggarsFavor : bool
var gaveGift : bool
var beenFarried : bool = false
var playerSpeedMultiplier : int = 1

#music variables
var negSound : AudioStreamPlayer2D
var posSound : AudioStreamPlayer2D
#music function
func playSound(sound : AudioStreamPlayer2D):
	sound.play()
