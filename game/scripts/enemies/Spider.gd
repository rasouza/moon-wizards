extends "BaseEnemy.gd"

### PROPRIEDADES #####

const DAMAGE = 2
const SPEED = 200

#######################

func _ready():
	HP = 10
	anim_up = "spider_up"
	anim_down = "spider_down"
	anim_left = "spider_left"
	anim_right = "spider_right"
	
func hit(player):
	.hit(player)
	knockback()