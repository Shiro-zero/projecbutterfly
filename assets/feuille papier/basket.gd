extends Node2D

var scaleX = 1
var scaleT = 1

var nb_feuilles = 0

func drop_feuille_in_basket_animation(feuille):
	print("animation")
	var tween = create_tween()
	var duration =  0.6	# Animate from start -> mid-point
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(feuille, "global_position", global_position, duration)
	tween.tween_property(self, "rotation_degrees", 0.0, 1.0)
	feuille.applyStat()
	nb_feuilles += 1

func get_nb_feuille():
	return nb_feuilles
	
func reset_feuilles():
	nb_feuilles = 0
