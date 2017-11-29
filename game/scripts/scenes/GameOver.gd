extends Panel


func _ready():
	# Initalization here
	pass



func _on_YES_button_pressed():
	Transition.fade_to("res://game/scenes/Splash_screen.tscn")