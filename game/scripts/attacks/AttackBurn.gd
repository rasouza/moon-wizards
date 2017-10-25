extends "BaseAttack.gd"

### PROPRIEDADES #####

const DAMAGE = 5

######################

func attack():
	atacando = true
	show()
	anim.play("start_attack")
func _on_Animation_finished():
	if (anim.get_current_animation() == "start_attack"): anim.play("attacking")

func attack_loop(delta):
	set_pos(attack_dir * RANGE)


