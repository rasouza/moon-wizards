extends "BaseEnemy.gd"

### PROPRIEDADES #####

const DAMAGE = 4

var aproximando

#######################

func _ready():
	HP = 20
	anim_up = "small_worm_up"
	anim_down = "small_worm_down"
	anim_left = "small_worm_left"
	anim_right = "small_worm_right"

func movimento(delta):
	if (distancia < ATTACK_RANGE - 100): aproximando = -1
	else: aproximando = 1
	
	var motion = aproximando * dir * SPEED * delta
	move(motion)

#func hit(player):
#	.hit(player)
