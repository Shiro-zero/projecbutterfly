extends Control
var preFeuille = preload("res://assets/feuille papier/feuille_papier.tscn")

@onready var draggable_controller = $DraggableController

@onready var audio = $Audio
@export var sfx_pickup = preload("res://sfx/Drag Paper.wav")
@export var sfx_drop = preload("res://sfx/Drag Paper.wav")

func pickup_sound():
	audio.stream = sfx_pickup
	audio.pitch_scale = randf_range(0.5, 2) # pitch légèrement aléatoire
	audio.volume_db = randf_range(-6, -2)      # volume entre -6dB et -2dB
	audio.play()

func drop_sound():
	audio.stream = sfx_drop
	audio.pitch_scale = randf_range(0.5, 2)
	audio.volume_db = randf_range(-6, -2)
	audio.play()

func _ready():
	
	$DialogueControlleur.show_random_dialogue("trump", "debut_niveau")
	spawn_loi(6)
	
func spawn_loi(n:int):
	for i in range(n):
		var temp = preFeuille.instantiate()
		temp.set_variable(i)
		draggable_controller.add_child(temp)
		draggable_controller.index_increment(temp)
		temp.position=Vector2(200,400)
		temp.rotation=randf_range(-.05, .05)

func _on_accueil_pressed() -> void:
	get_tree().change_scene_to_file("res://Menu.tscn")
		
