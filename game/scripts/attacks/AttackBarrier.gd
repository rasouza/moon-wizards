extends "BaseAttack.gd"

func attack_loop(delta):
	set_rot(atan2(attack_dir.x, attack_dir.y))

func _on_Area2D_area_enter(area):
	print("Colidiu Barreira!")
