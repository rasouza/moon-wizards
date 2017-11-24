extends Node2D

onready var player = get_tree().get_nodes_in_group("player")[0]
onready var indicator = get_node("Indicator")

var position_on_screen = Vector2(140, 30)

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	var offset = -get_parent().get_global_transform_with_canvas().get_origin()
	set_pos(offset + position_on_screen)	
	indicator.set_scale(Vector2(player.HP / 100.0, 1.0))