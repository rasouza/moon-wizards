extends "BaseAttack.gd"

func attack_loop(delta):
	set_rot(atan2(attack_dir.x, attack_dir.y) - 1.5)