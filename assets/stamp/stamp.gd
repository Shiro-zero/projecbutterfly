extends draggable

@export var is_accepted_stamp = true
var accepted_mark = preload ("res://assets/stamp/accepted_mark.tscn")
var refused_mark = preload ("res://assets/stamp/refused_mark.tscn")
var is_charged = true

func _ready():
	if is_accepted_stamp:
		$Sprite2D.texture=load("res://assets/stamp/stamp.png")
	else:
		$Sprite2D.texture= load("res://assets/stamp/stampx.png")

func stamp(feuille):
	if is_charged:
		var mark = null
		if is_accepted_stamp:
			mark = accepted_mark.instantiate()
			$Sprite2D.texture=load("res://assets/stamp/stamp.png")
		else:
			mark = refused_mark.instantiate()
			$Sprite2D.texture= load("res://assets/stamp/stampx.png")
			
		feuille.get_child(3).add_child(mark)
		mark.global_position = global_position
		feuille.is_accepted = is_accepted_stamp
		is_charged = false

func recharge_stamp():
	is_charged = true
