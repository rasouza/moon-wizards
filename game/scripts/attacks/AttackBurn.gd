extends "BaseAttack.gd"

func attack_loop(delta):
	set_pos(attack_dir * RANGE)

func _on_Area2D_area_enter(area):
	print("Colidiu!")
