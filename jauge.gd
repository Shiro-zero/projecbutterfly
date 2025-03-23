extends Control

@onready var bar = $ProgressBar
@onready var label = $Name

@export var nom = "Lorem"
@export var max_value = 100
@export var value = 100
@export var color = "ecb012"

func _ready() -> void:
	bar.max_value = max_value
	bar.value = value
	
	label.text = nom
	
	var sb = StyleBoxFlat.new()
	bar.add_theme_stylebox_override("fill", sb)
	sb.bg_color = Color(color)

func update_value(nVal : int):
	bar.value += nVal
	if bar.value <= 0 and nom != "Fatigue":
		Global.is_game_over = true
	
