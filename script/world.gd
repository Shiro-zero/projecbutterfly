extends Control
var preFeuille = preload("res://assets/feuille papier/feuille_papier.tscn")

@onready var draggable_controller = $DraggableController
@onready var day = $Day/Crn_Day
@onready var clock = $Day/Clock
@onready var game_over_panel = $Game_Over
@onready var basket = $Basket

@onready var audio = $Audio
@export var sfx_pickup = preload("res://sfx/Drag Paper.wav")
@export var sfx_drop = preload("res://sfx/Drag Paper.wav")

var nb_feuilles_crn_day

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
	update_nb_feuilles_crn_day()
	$DialogueControlleur.show_random_dialogue("trump", "debut_niveau")
	spawn_loi(nb_feuilles_crn_day)
	day.text = "Lundi"

func _process(delta: float) -> void:
	if clock.is_over() or basket.get_nb_feuille() == nb_feuilles_crn_day:
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
	update_nb_feuilles_crn_day()
	spawn_loi(nb_feuilles_crn_day)
	clock.start_timer()

func game_over():
	clock.stop_timer()
	game_over_panel.set_visible(true)

func update_nb_feuilles_crn_day():
	nb_feuilles_crn_day = count_items(read("res://assets/text/Info.json"), Global.day)
	
func count_items(data, main_key) -> int:
		return data[str(main_key)].size()
	
func read(file_path):
	# Check if the file exists
	if FileAccess.file_exists(file_path):
		# Open the file for reading
		var file = FileAccess.open(file_path, FileAccess.READ)
		if file:
			# Read the file content
			var json_data = file.get_as_text()
			file.close()

			# Create an instance of JSON
			var json_object = JSON.parse_string(json_data)

			return json_object
	else:
		print("File does not exist.")
		return "File does not exist."
