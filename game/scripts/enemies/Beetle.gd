extends "BaseEnemy.gd"

### PROPRIEDADES #####

const DAMAGE = 2

#######################

func _ready():
	HP = 20
	anim_up = "beetle_up"
	anim_down = "beetle_down"
	anim_left = "beetle_left"
	anim_right = "beetle_right"
	
func hit(player):
	.hit(player)