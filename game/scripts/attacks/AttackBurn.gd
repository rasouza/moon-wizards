extends "BaseAttack.gd"

### PROPRIEDADES #####

const DAMAGE = 5

######################

func attack_loop(delta):
	set_pos(attack_dir * RANGE)


