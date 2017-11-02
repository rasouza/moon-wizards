extends "BaseEnemy.gd"

### PROPRIEDADES #####

const DAMAGE = 4
const SPEED = 200

#######################

func _ready():
	HP = 10
	anim_up = "pidgeon_up"
	anim_down = "pidgeon_down"
	anim_left = "pidgeon_left"
	anim_right = "pidgeon_right"
	
func hit(player):
	.hit(player)
	knockback()
