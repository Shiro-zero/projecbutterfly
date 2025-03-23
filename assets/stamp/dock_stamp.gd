extends Node2D

@export var color = "green"

func drop_sound():
	pass
	
func _ready() -> void:
	var ink = $ColorRect/interieur
	if color == "green":
		ink.set_color(Color("GREEN"))
	elif color == "red":
		ink.set_color(Color("RED"))
	
