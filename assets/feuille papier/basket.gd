extends Node2D

func drop_feuille_in_basket_animation(feuille):
	print("animation")
	var tween = create_tween()
	var duration =  0.25	# Animate from start -> mid-point
	tween.set_ease(Tween.EASE_OUT)
	feuille
	tween.tween_property(feuille, "global_position", global_position, duration)
	pass
