extends "BaseEnemy.gd"

### PROPRIEDADES #####

const DAMAGE = 2

#######################

func _ready():
	HP = 10
	anim_up = "bat_up"
	anim_down = "bat_down"
	anim_left = "bat_left"
	anim_right = "bat_right"
	
func hit(player):
	.hit(player)
	knockback()