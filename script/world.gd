extends Node2D
var preFeuille = preload("res://assets/feuille papier/feuille_papier.tscn")
func _ready():
	spawn_loi(5)
	
func spawn_loi(n:int):
	for i in range(n):
		var temp = preFeuille.instantiate()
		$DraggableController.add_child(temp)
		temp.position=Vector2(800,400)
		temp.rotation=randf_range(-.05, .05)
