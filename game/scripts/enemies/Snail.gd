extends "BaseEnemy.gd"

### PROPRIEDADES #####

const DAMAGE = 4

#######################

func _ready():
	HP = 20
	anim_up = "snail_up"
	anim_down = "snail_down"
	anim_left = "snail_left"
	anim_right = "snail_right"
	
#func hit(player):
#	.hit(player)
