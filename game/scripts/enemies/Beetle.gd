extends "BaseEnemy.gd"

### PROPRIEDADES #####

const DAMAGE = 2
const SPEED = 200

#######################

func _ready():
	HP = 10
	anim_up = "beetle_up"
	anim_down = "beetle_down"
	anim_left = "beetle_left"
	anim_right = "beetle_right"
	
func hit(player):
	.hit(player)
	knockback()