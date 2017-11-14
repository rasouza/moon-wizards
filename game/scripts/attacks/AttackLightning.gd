extends "BaseAttack.gd"

### PROPRIEDADES #####

const DAMAGE = 20
const INTERVAL_SHOT = 2

var wizard
var timer

var enemies = {}

######################

func _ready():
	get_node("Area2D").connect("body_exit", self, "_on_body_exit") # Colisor

func _init(wizard):
	self.wizard = wizard
	self.timer = Timer.new()

func attack():
	wizard.add_child(timer)
	timer.set_one_shot(false)
	timer.set_wait_time(INTERVAL_SHOT)
	timer.connect("timeout", self, "disparo")
	timer.start()

func stop():
	timer.stop()
	timer.disconnect("timeout", self, "disparo")
	wizard.remove_child(timer)

func disparo():
	set_pos(attack_dir * RANGE)
	if (not enemies.empty()):
		for i in enemies:
			enemies[i].HP -= DAMAGE
			enemies[i].get_hit(self)

func hit( enemy ):
	enemies[enemy.get_name()] = enemy

func _on_body_exit( body ):
	enemies.erase(body.get_name())


