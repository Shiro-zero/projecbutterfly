extends Node2D


const COLLISION_MASK_DRAGGABLE = 1
const COLLISION_MASK_STAMP_SLOT = 2
const DRAGGABLE_HOVER = Vector2(1.1, 1.1)
const DRAGGABLE_HOVER_OFF = Vector2(1, 1)

var screen_size
var draggable_dragged
var draggable
var is_draggable_hovering
var drag_offset = Vector2.ZERO

func _ready() -> void:
	screen_size = get_viewport_rect()
	
func _process(delta: float) -> void:
	follow_mouse()
	
func _input(event: InputEvent):
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_LEFT:		#s'assure que le bouton appuiyer est le bouton gauche de souris
		if event.pressed :
			# Action au click
			print("click")
			draggable = raycast_check(COLLISION_MASK_DRAGGABLE)
			start_drag()
		else:
			# Action au déclick
			print("déclick")
			end_drag()

func connect_draggable_signals(draggable):
	draggable.connect('hover', on_draggable_hover)
	draggable.connect('hover_off', on_draggable_hover_off)
	
func raycast_check(mask):
	var world = get_world_2d().direct_space_state
	# Va chercher la position de la sourie pour selectionner une carte
	var mouse = PhysicsPointQueryParameters2D.new()
	mouse.position = get_global_mouse_position()
	mouse.collide_with_areas = true
	mouse.collision_mask = mask
	#pour vérifier le mask
	#print(world.intersect_point(mouse))
	# Selectionne la carte pour pouvoir la déplacer
	var objects_colliders = world.intersect_point(mouse)
	if objects_colliders.size() > 0:
		return draggable_on_top(objects_colliders)
	return null
	
func draggable_on_top(draggables):
	# Assume que la première carte est la plus grande
	var draggable_on_top = draggables[0].collider.get_parent()
	# Regarde pour la carte avec le plus haut z-index
	for i in range(1, draggables.size()):
		var current_draggable = draggables[i].collider.get_parent()
		if current_draggable.z_index > draggable_on_top.z_index:
			draggable_on_top = current_draggable
	return draggable_on_top

func follow_mouse():
	if draggable_dragged:
		var mouse_pos = get_global_mouse_position()
		draggable_dragged.global_position = mouse_pos + drag_offset 

func start_drag():
	if draggable :
		highlight_draggable(draggable_dragged, true)
		draggable_dragged = draggable
		drag_offset = draggable_dragged.global_position - get_global_mouse_position()

func end_drag():
	if draggable_dragged:
		highlight_draggable(draggable_dragged, false)
		var slot = raycast_check(COLLISION_MASK_STAMP_SLOT)
		if slot:
			if draggable_dragged.is_in_group("stamp"):
				draggable_dragged
				
		draggable_dragged = null
		#ajouter logique de relache ici vérification d'ou il a été relaché
		
func on_draggable_hover():
	#if !is_draggable_hovering:
	print("grossit")
	is_draggable_hovering = true
	highlight_draggable(draggable, true)
		
func on_draggable_hover_off():
	#if !is_draggable_hovering:
	print("grossit")
	is_draggable_hovering = false
	highlight_draggable(draggable, false)
		
func highlight_draggable(draggable, hover: bool):
	print(draggable)
	if hover:
		draggable.scale = DRAGGABLE_HOVER
		draggable.z_index = draggable.hover_base_index
	else:
		draggable.scale = DRAGGABLE_HOVER_OFF
		draggable.z_index = draggable.base_z_index
