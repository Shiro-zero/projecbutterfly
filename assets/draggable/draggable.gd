extends Node2D
class_name draggable

@export var is_dragged = false
@export var base_z_index = 1
@export var hover_z_index = 2

func _ready() -> void:
	get_parent().connect_draggable_signals(self)
	
func _on_area_2d_mouse_entered() -> void:
	emit_signal('hover', self)
	#print("hover_on")


func _on_area_2d_mouse_exited() -> void:
	emit_signal('hover_off', self)
	#print("hover_off")
	
func hover_on():
	z_index = hover_z_index
	
func hover_off():
	z_index = base_z_index
