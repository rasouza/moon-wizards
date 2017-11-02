extends "BaseEnemy.gd"

### PROPRIEDADES #####

const DAMAGE = 2

#######################

func _ready():
	HP = 20
	anim_up = "spider_up"
	anim_down = "spider_down"
	anim_left = "spider_left"
	anim_right = "spider_right"
	
func hit(player):
	.hit(player)