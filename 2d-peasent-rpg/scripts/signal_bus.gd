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

#game variables
var gold : int
var food : int
var luck : int


##gameover signal to carry info to another scene??
signal bring_to_end_screen(foodLeft, goldLeft)
