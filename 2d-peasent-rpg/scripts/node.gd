extends Node
@onready var positive_sond: AudioStreamPlayer = $positive_sond
@onready var neg_sound: AudioStreamPlayer = $neg_sound


func playNegSound():
	neg_sound.play()
	
func playPosSound():
	positive_sond.play()
