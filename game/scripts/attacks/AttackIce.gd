extends "GeneralAttack.gd"

var distancia = 50 # Distância entre o mago e o ataque
var speed = 400

func _ready():
	._ready()
	dano = 10
	set_z(-10)

func attack_frame():
	var wizard_pos = wizard.get_global_pos()
	var mouse = get_viewport().get_mouse_pos()
	var attack_dir = (mouse - wizard_pos).normalized()
	
	#var motion = attack_dir * speed * delta
	#set_pos(get_pos() + motion)
	
	set_pos(attack_dir*distancia)