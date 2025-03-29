extends Node
#holds all signals..

#village signals
signal leftVillage

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
var beenFarried : bool
var playerSpeedMultiplier : int = 1
