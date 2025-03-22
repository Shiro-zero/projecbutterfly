extends Node2D

const OBJECT_HOVER = Vector2(1.05, 1.05)
const OBJECT_HOVER_OFF = Vector2(1, 1)

var object_dragged
var object
var is_object_hovering

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	follow_mouse()
	
func _input(event: InputEvent):
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_LEFT:		#s'assure que le bouton appuiyer est le bouton gauche de souris
		if event.pressed :
			# Action au click
			if ! player_reference.is_in_battle and !player_reference.is_paused():
				card = raycast_check(COLLISION_MASK_CARD)
				if card:
					start_drag()
		else:
			# Action au déclick
			if card_dragged:
				end_drag()
			
func raycast_check(mask):
	var world = get_world_2d().direct_space_state
	# Va chercher la position de la sourie pour selectionner une carte
	var mouse = PhysicsPointQueryParameters2D.new()
	mouse.position = get_global_mouse_position()
	mouse.collide_with_areas = true
	mouse.collision_mask = mask
	# Selectionne la carte pour pouvoir la déplacer
	var objects_colliders = world.intersect_point(mouse)
	if objects_colliders.size() > 0:
		return object_on_top(objects_colliders)
	return null
	
	
func follow_mouse():
	if object_dragged:
		var mouse_pos = get_global_mouse_position()
		object_dragged.global_position = get_global_mouse_position()
