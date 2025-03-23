extends Control
var preFeuille = preload("res://assets/feuille papier/feuille_papier.tscn")

@onready var draggable_controller = $DraggableController
@onready var day = $Day/Crn_Day
@onready var clock = $Day/Clock
@onready var game_over_panel = $Game_Over
@onready var basket = $Basket

func _ready():
	$DialogueControlleur.show_random_dialogue("trump", "debut_niveau")
	spawn_loi(6)
	day.text = "Lundi"

func _process(delta: float) -> void:
	if clock.is_over() or basket.get_nb_feuille() == 6:
		change_day()
		
	if Global.is_game_over:
		game_over()

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
	
func remove_garbage():
	for child in draggable_controller.get_children():
		if child.is_in_group("feuille"):
			child.queue_free()
	basket.reset_feuilles()
		
func change_day():
	
	Global.day += 1
	
	var fatigue = $Stats/Fatigue
	fatigue.update_value(-20)
	
	var day_str = ""
	
	match Global.day:
		0 : day_str = "Lundi"
		1 : day_str = "Mardi"
		2 : day_str = "Mercredi"
		3 : day_str = "Jeudi"
		4 : day_str = "Vendredi"
		5 : day_str = "Samedi"
		6 : day_str = "Dimanche"
		_: day_str = "What did ya expect..."
	
	day.text = day_str
	remove_garbage()
	spawn_loi(6)
	clock.start_timer()

func game_over():
	clock.stop_timer()
	game_over_panel.set_visible(true)
