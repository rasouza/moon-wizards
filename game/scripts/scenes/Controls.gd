extends Panel

func _ready():
	self.set_process_input(true)

func _input(event):
	if (event.is_action_pressed("ui_accept")):
		#print("apertou algo!")
		Transition.fade_to("res://game/scenes/Tutorial.tscn")