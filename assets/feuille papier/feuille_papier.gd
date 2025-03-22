extends draggable

var is_accepted = null
var instance_index = 0
var stats = {}

@onready var text = preload("res://script/textGenerator.gd").new()

func _ready():
	$ColorRect/title.text = "[center]"+text.generate_title(instance_index)+"[/center]"
	$ColorRect/tbody.text = text.generate_text(instance_index)
	stats = text.generate_stat(instance_index)
	print(str(stats))

func set_variable(i):
	instance_index = i
