extends Control

func _on_jouer_pressed() -> void:
	get_tree().change_scene_to_file("res://world.tscn")

func _on_crédits_pressed() -> void:
	get_tree().change_scene_to_file("res://Credits.tscn")

func _on_quitter_pressed() -> void:
	get_tree().quit()
