extends Node2D
var preFeuille = preload("res://assets/feuille papier/feuille_papier.tscn")
@onready var draggable_controller = $DraggableController
func _ready():
	spawn_loi(3)
	
func spawn_loi(n:int):
	for i in range(n):
		var temp = preFeuille.instantiate()

		temp.set_variable(i)
		draggable_controller.add_child(temp)
		draggable_controller.index_increment(temp)
		
		temp.position=Vector2(800,400)
		temp.rotation=randf_range(-.05, .05)


func _on_accueil_pressed() -> void:
	get_tree().change_scene_to_file("res://Menu.tscn")
		
