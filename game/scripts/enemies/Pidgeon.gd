extends "BaseEnemy.gd"

### PROPRIEDADES #####

const HP = 20
const DAMAGE = 4

#######################

func _ready():
	anim_up = "pidgeon_up"
	anim_down = "pidgeon_down"
	anim_left = "pidgeon_left"
	anim_right = "pidgeon_right"