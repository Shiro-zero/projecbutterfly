extends Node

@onready var draggable_controller = $DraggableController

func _ready():
	spawn_junk(5)
	
func spawn_junk(n:int):
	for i in range(n):
		var junk = junks[randi()%junks.size()].instantiate()
		draggable_controller.add_child(junk)
		draggable_controller.index_increment(junk)
		junk.position=Vector2(-300,500)
		var tween = create_tween()
		
