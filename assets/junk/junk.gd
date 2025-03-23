extends Node2D

@onready var audio = $Audio
@export var sfx_pickup = preload("res://sfx/Drag Paper.wav")
@export var sfx_drop = preload("res://sfx/Drag Paper.wav")

func pickup_sound():
	if sfx_pickup:
		audio.stream = sfx_pickup
		audio.pitch_scale = randf_range(1.5, 2) # pitch légèrement aléatoire
		audio.volume_db = randf_range(-6, -2)      # volume entre -6dB et -2dB
		audio.play()

func drop_sound():
	if sfx_drop:
		audio.stream = sfx_drop
		audio.pitch_scale = randf_range(1.5, 2)
		audio.volume_db = randf_range(-6, -2)
		audio.play()
