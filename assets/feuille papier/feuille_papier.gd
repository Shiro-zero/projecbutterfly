extends draggable
var is_accepted = null
@onready var text = preload("res://script/textGenerator.gd").new()
func _ready():
	$ColorRect/title.text = "[center]"+text.generate_title()+"[/center]"
	$ColorRect/tbody.text = text.generate_text()
