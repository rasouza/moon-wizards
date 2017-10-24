extends "BaseEnemy.gd"

### PROPRIEDADES #####

const HP = 10
const DAMAGE = 2

#######################

func _ready():
	anim_up = "bat_up"
	anim_down = "bat_down"
	anim_left = "bat_left"
	anim_right = "bat_right"