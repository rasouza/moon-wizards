extends Panel

func _ready():
	pass

func _on_HATE_button_pressed():
	Transition.humor = "HATE"
	Transition.fade_to("res://game/scenes/Chosen_Writing.tscn")

func _on_LOVE_button_pressed():
	Transition.humor = "LOVE"
	Transition.fade_to("res://game/scenes/Chosen_Writing.tscn")

func _on_LOGIC_button_pressed():
	Transition.humor = "LOGIC"
	Transition.fade_to("res://game/scenes/Chosen_Writing.tscn")

func _on_POWER_button_pressed():
	Transition.humor = "POWER"
	Transition.fade_to("res://game/scenes/Chosen_Writing.tscn")