extends Control

func _on_jouer_pressed() -> void:
	Global.is_game_over = false
	Global.day = 0
	get_tree().change_scene_to_file("res://world.tscn")

func _on_crédits_pressed() -> void:
	get_tree().change_scene_to_file("res://Credits.tscn")

func _on_quitter_pressed() -> void:
	get_tree().quit()


func _on_mode_infini_pressed() -> void:
	get_tree().change_scene_to_file("res://infini.tscn")
