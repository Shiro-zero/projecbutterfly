extends draggable

var is_accepted = null
var instance_index = 0
var stats = {}
@onready var audio = $Audio
@onready var text = preload("res://script/textGenerator.gd").new()
@export var sfx_pickup = preload("res://sfx/Drag Paper.wav")
@export var sfx_drop = preload("res://sfx/Drag Paper.wav")

func pickup_sound():
	audio.stream = sfx_pickup
	audio.pitch_scale = randf_range(1.5, 2) # pitch légèrement aléatoire
	audio.volume_db = randf_range(-6, -2)      # volume entre -6dB et -2dB
	audio.play()

func drop_sound():
	audio.stream = sfx_drop
	audio.pitch_scale = randf_range(1.5, 2)
	audio.volume_db = randf_range(-6, -2)
	audio.play()

func _ready():
	$ColorRect/title.text = "[center]"+text.generate_title(instance_index)+"[/center]"
	$ColorRect/tbody.text = text.generate_text(instance_index)
	stats = text.generate_stat(instance_index)

func set_variable(i):
	instance_index = i

func applyStat():
	var statsJauge = $"../../Stats"
	statsJauge.get_child(1).update_value(5) # Augmente la fatigue
	
	var pArray = stats['plus'].split(" ")
	var lArray = stats['less'].split(" ")
	
	for stat in pArray:
		var value = (len(stat) + 1) * 5
		
		match(stat[0]):
			"S" : statsJauge.get_child(0).update_value(value)
			"F" : statsJauge.get_child(1).update_value(value)
			"T" : statsJauge.get_child(2).update_value(value)
			"O" : statsJauge.get_child(3).update_value(value)
			
	for stat in lArray:
		var value = (len(stat) + 1) * 5
		
		match(stat[0]):
			"S" : statsJauge.get_child(0).update_value(-value)
			"F" : statsJauge.get_child(1).update_value(-value)
			"T" : statsJauge.get_child(2).update_value(-value)
			"O" : statsJauge.get_child(3).update_value(-value)
			
func knock_back() -> void:
	var tween = create_tween()
	# Projection vers le bas avec rotation aléatoire
	tween.parallel().tween_property(self, "position", Vector2(position.x + randf_range(-50, 50), position.y + 300), 0.8)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		
	tween.parallel().tween_property(self, "rotation_degrees", rotation_degrees + randi_range(-10, 10), 0.8)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
