extends "BaseAttack.gd"

### PROPRIEDADES #####

const DAMAGE = 5

######################

var enemies = {}
var counter = 0

func _ready():
	get_node("Area2D").connect("body_exit", self, "_on_body_exit") # Colisor

func attack_loop(delta):
	set_pos(attack_dir * RANGE)
	counter += delta
	if (counter >= 1 and not enemies.empty()):
		counter = 0
		for i in enemies:
			enemies[i].HP -= DAMAGE
			enemies[i].get_hit(self)
	
func hit( enemy ):
	enemies[enemy.get_name()] = enemy

func _on_body_exit( body ):
	enemies.erase(body.get_name())


