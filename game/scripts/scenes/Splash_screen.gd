extends Panel


func _ready():
	# Initalization here
	pass



func _on_PLAY_button_pressed():
	get_node("/root/global").goto_scene("res://game/scenes/Cenario2.tscn")