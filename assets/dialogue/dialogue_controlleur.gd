extends Node

@onready var dialogue_box = $DialogueBox
@onready var dialogue_label = $DialogueBox/Label
@onready var portrait = $DialogueBox/Portrait


var portraits 

var dialogues = {}
var typing_speed = 0.03
var typing_timer = Timer.new()
var full_text = ""
var current_index = 0

func _ready():
	load_dialogues("res://assets/text/dialogue.json")
	add_child(typing_timer)
	typing_timer.connect("timeout", Callable(self, "_on_typing_tick"))
	dialogue_box.visible = false
	
	var baseImage =load("res://assets/img/titlescreen.png")

	var trump_texture_rect = Sprite2D.new()
	trump_texture_rect.texture = baseImage
	trump_texture_rect.region_enabled = true
	trump_texture_rect.region_rect =Rect2( Vector2(460, 100), Vector2(260, 260))


	# Create a TextureRect node for Secrétaire
	var secretaire_texture_rect = Sprite2D.new()
	secretaire_texture_rect.texture = baseImage
	secretaire_texture_rect.region_enabled = true
	secretaire_texture_rect.region_rect =Rect2( Vector2(260, 260), Vector2(260, 260))

	
	portraits = {
		"trump": trump_texture_rect,
		"secretaire": secretaire_texture_rect
	}

func load_dialogues(path: String):
	var file = FileAccess.open(path, FileAccess.READ)
	if file:
		var content = file.get_as_text()
		var json = JSON.parse_string(content)
		if json:
			dialogues = json
		else:
			print("Erreur de parsing JSON")

# Appelle ceci : show_random_dialogue("secretaire", "hair")
func show_random_dialogue(character: String, situation: String):
	#print(dialogues)
	if dialogues.has(character) and dialogues[character].has(situation):
		#print("dialogye fait")
		if portraits.has(character):
			portrait.texture = portraits[character].texture
			portrait.region_enabled = portraits[character].region_enabled
			portrait.region_rect =portraits[character].region_rect

		var lines = dialogues[character][situation].values()
		full_text = lines[randi() % lines.size()]
		current_index = 0
		dialogue_label.text = ""
		dialogue_box.visible = true
		typing_timer.start(typing_speed)
	else:
		print("Dialogue non trouvé pour : ", character, "/", situation)

func _on_typing_tick():
	if current_index < full_text.length():
		dialogue_label.text += full_text[current_index]
		current_index += 1
	else:
		typing_timer.stop()
		await get_tree().create_timer(2.0).timeout
		dialogue_box.visible = false
