extends Node
#holds all signals..

#choice window signal
signal choice1
signal choice2
signal choice_made

#hazard signal
signal playerHit

#player global variable
var player_location

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


##gameover signal to carry info to another scene??
signal bring_to_end_screen(foodLeft, goldLeft)
