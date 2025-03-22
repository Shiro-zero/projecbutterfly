extends draggable

@export var is_accepted_stamp = true
var accepted_mark = preload ("res://assets/stamp/accepted_mark.tscn")
var refused_mark = preload ("res://assets/stamp/refused_mark.tscn")
var is_charged = true


func stamp(feuille:Node2D):
	if is_charged:
		var mark = null
		if is_accepted_stamp:
			mark = accepted_mark.instantiate()
		else:
			mark = refused_mark.instantiate()
		feuille.get_child(0).add_child(mark)
		mark.global_position = global_position
		feuille.is_accepted = is_accepted_stamp
