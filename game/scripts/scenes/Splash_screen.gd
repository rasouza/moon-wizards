extends Panel


func _ready():
	# Initalization here
	pass



func _on_PLAY_button_pressed():
	Transition.fade_to("res://game/scenes/CenarioPlanicie.tscn")