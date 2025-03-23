extends Control

func _on_rejouer_pressed() -> void:
	Global.is_game_over = false
	Global.day = 0
	set_visible(false)
	get_tree().reload_current_scene()

func _on_quitter_pressed() -> void:
	get_tree().change_scene_to_file("res://Menu.tscn")
