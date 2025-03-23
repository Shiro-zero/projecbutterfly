extends Node2D


const COLLISION_MASK_DRAGGABLE = 1
const COLLISION_MASK_FEUILLE = 2
const COLLISION_MASK_STAMP_DOCK = 4
const COLLISION_MASK_BASKET = 8

const DRAGGABLE_HOVER = Vector2(1.1, 1.1)
const DRAGGABLE_HOVER_OFF = Vector2(1, 1)

var screen_size
var draggable_dragged
var draggable
var is_draggable_hovering
var drag_offset = Vector2.ZERO
var last_index = 1


func _ready() -> void:
	screen_size = get_viewport_rect()
	print()
	
func _process(_delta: float) -> void:
	follow_mouse()
	
func _input(event: InputEvent):
	if event is InputEventMouseButton and  event.button_index == MOUSE_BUTTON_LEFT:		#s'assure que le bouton appuiyer est le bouton gauche de souris
		if event.pressed :
			# Action au click
			#print("click")
			draggable = raycast_check(COLLISION_MASK_DRAGGABLE)
			start_drag()
		else:
			# Action au déclick
			#print("déclick")
			end_drag()
	
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
		draggable_dragged = draggable
		highlight_draggable(draggable_dragged, true)
		drag_offset = draggable_dragged.global_position - get_global_mouse_position()
		if draggable_dragged.is_in_group("feuille"):
			draggable_dragged.rotation = 0

func end_drag():
	if draggable_dragged:
		highlight_draggable(draggable_dragged, false)
		
		if draggable_dragged.is_in_group("stamp"):
			print("drop stamp")
			var feuille = raycast_check(COLLISION_MASK_FEUILLE)
			if feuille:
				print("stamp feuille")
				draggable_dragged.stamp(feuille)
			else:
				var dock = raycast_check(COLLISION_MASK_STAMP_DOCK)
				if dock:
					print(dock)
					if dock.color == "green" && draggable_dragged.is_accepted_stamp:
						draggable_dragged.is_charged = true
						print('recharge vert')
					elif dock.color == "red" && !draggable_dragged.is_accepted_stamp:
						draggable_dragged.is_charged = true
						print('recharge rouge')
					pass
		if draggable_dragged.is_in_group("feuille"):
			var tween = create_tween()
			var target_rotation = randf_range(-0.05, 0.05)
			draggable_dragged.rotation=target_rotation
			var basket = raycast_check(COLLISION_MASK_BASKET)
			if basket:
				print("basket existe")
				#si il y a un stamp
				if draggable_dragged.is_accepted == null:
					$"../Stats/Mr_President".update_value(-5)
					$"../Stats/Stress".update_value(5)
					#ajouter message trump
					draggable_dragged.knock_back()
				else :
					basket.drop_feuille_in_basket_animation(draggable_dragged)
					#desactive la collision
					draggable_dragged.get_node("Area2D").get_node("CollisionShape2D").disabled = true
					#mettre info journal ici
					

		draggable_dragged = null
		#ajouter logique de relache ici vérification d'ou il a été relaché
		

func highlight_draggable(drag, hover: bool):
	#print(draggable)
	if hover:
		pass
		drag.scale = DRAGGABLE_HOVER
		if(!drag.is_in_group("stamp")):
			index_increment(drag)
	else:
		drag.scale = DRAGGABLE_HOVER_OFF

func index_increment(obj):
	last_index += 1
	obj.z_index = last_index
