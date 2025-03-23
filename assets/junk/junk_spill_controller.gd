extends Node

@onready var draggable_controller = $"../DraggableController"
var junks = [
	preload("res://assets/junk/junk_doc.tscn"),
]
var apple = preload("res://assets/junk/junk_apple.tscn")
var number_of_junk = 5
@onready var junk_timer = Timer.new()

func _ready():
	add_child(junk_timer)
	junk_timer.one_shot = true
	var delay = randf_range(99999.0, 99999.0) # entre 1 et 3 secondes par exemple
	junk_timer.start(delay)
	junk_timer.timeout.connect(_random_spawn_junk)
	

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

func _random_spawn_junk():
	# Spawne un junk
	spawn_junk(5)
	# Redémarre le timer avec un délai aléatoire
