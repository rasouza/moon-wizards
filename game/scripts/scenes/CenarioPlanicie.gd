extends Node2D

func _ready():
	var show_list = []
	show_list.push_back("\nI reckon there are some books around here")
	show_list.push_back("\n...for some reason...")
	show_list.push_back("\nthey might be what I'm looking for, \n\nlet's see if I can find them")
	
	get_node("TextIndicator").show_text_list(show_list)
	
	var path = "res://game/scenes/Floresta.tscn"
	
	get_node("TilesObjects/Book").scene_path = path
	get_node("TilesObjects/Book 2").scene_path = path
	get_node("TilesObjects/Book 3").scene_path = path
	get_node("TilesObjects/Book 4").scene_path = path
