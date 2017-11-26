extends Node2D

onready var player = get_tree().get_nodes_in_group("player")[0]
onready var burn = get_node("Burn")
onready var barrier = get_node("Barrier")
onready var ice = get_node("Ice")
onready var lightning = get_node("Lightning")

var position_on_screen = Vector2(50, 550)

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	var offset = -get_parent().get_global_transform_with_canvas().get_origin()
	set_pos(offset + position_on_screen)
	
	var selected = player.active_attack.get_name()
	
	if (selected == "Burn"):
		burn.show()
		barrier.hide()
		ice.hide()
		lightning.hide()
	
	if (selected == "Barrier"):
		burn.hide()
		barrier.show()
		ice.hide()
		lightning.hide()
	
	if (selected == "Ice"):
		burn.hide()
		barrier.hide()
		ice.show()
		lightning.hide()
	
	if (selected == "Lightning"):
		burn.hide()
		barrier.hide()
		ice.hide()
		lightning.show()