extends "BaseEnemy.gd"

### PROPRIEDADES #####

const DAMAGE = 4
const SPEED = 200
const ATTACK_COOLDOWN = 5

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