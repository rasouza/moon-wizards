extends "GeneralAttack.gd"



func attack_frame():
	set_rot(atan2(attack_dir.x, attack_dir.y))