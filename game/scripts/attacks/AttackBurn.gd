extends "BaseAttack.gd"

var distancia = 50 # Distância entre o mago e o ataque

func _ready():
	._ready()
	dano = 10
	set_z(-10)

func attack_frame():
	set_pos(attack_dir*distancia)