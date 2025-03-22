extends Node2D
var preFeuille = preload("res://assets/feuille papier/feuille_papier.tscn")
var junks = [
	preload("res://assets/junk/junk_apple.tscn"), 
	preload("res://assets/junk/junk_doc.tscn"),
]
var apple = preload("res://assets/junk/junk_apple.tscn")
@onready var draggable_controller = $DraggableController
var number_of_junk = 5
@onready var junk_timer = Timer.new()

func _ready():
	spawn_loi(5)
	add_child(junk_timer)
	junk_timer.one_shot = true
	var delay = randf_range(5.0, 10.0) # entre 1 et 3 secondes par exemple
	junk_timer.start(delay)
	junk_timer.timeout.connect(_random_spawn_junk)
	
func _random_spawn_junk():
	# Spawne un junk
	spawn_junk(5)
	# Redémarre le timer avec un délai aléatoire
	

func spawn_junk(n:int):
	for i in range(n):
		affiche_junk(junks[randi()%junks.size()].instantiate())
	affiche_junk(apple.instantiate())

func affiche_junk(junk):
	draggable_controller.add_child(junk)
	draggable_controller.index_increment(junk)
	junk.position=Vector2(500, -800)
	var tween = create_tween()
	tween.parallel().tween_property(junk, "position", Vector2(randi_range(300, 1200), randi_range(0, 800)), 0.8).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(junk, "rotation_degrees", randi_range(-45, 45), 0.5).set_ease(Tween.EASE_OUT)
	
	
func spawn_loi(n:int):
	for i in range(n):
		var temp = preFeuille.instantiate()
		draggable_controller.add_child(temp)
		draggable_controller.index_increment(temp)
		temp.position=Vector2(800,400)
		temp.rotation=randf_range(-.05, .05)

func _on_accueil_pressed() -> void:
	get_tree().change_scene_to_file("res://Menu.tscn")
		
