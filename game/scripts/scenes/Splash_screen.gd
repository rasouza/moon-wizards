extends Panel

func _ready():
	pass

func _on_PLAY_button_pressed():
	Transition.fade_to("res://game/scenes/Controls.tscn")