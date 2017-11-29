extends KinematicBody2D

const TYPE = preload("types.gd")

func _ready():
	get_node("Area2D").connect("body_enter", self, "_on_body_enter") # Colisor do player

func _on_body_enter( body ): 
	if (body.get("type") != null and body.type == TYPE.PLAYER): 
		Transition.fade_to("res://game/scenes/CenarioPlanicie.tscn")