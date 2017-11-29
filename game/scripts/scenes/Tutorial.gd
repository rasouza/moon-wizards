extends Node2D

func _ready():
	var show_list = []
	show_list.push_back("\n...")
	show_list.push_back("\nthis weather feels nice...\n\nI want to write today")
	show_list.push_back("\nbut first, \n\nI need to find inspiration")

	get_node("TextIndicator").show_text_list(show_list)
