extends "BaseEnemy.gd"

### PROPRIEDADES #####

const DAMAGE = 4

var aproximando
var timer = Timer.new()

#######################

func _ready():
	HP = 20
	anim_up = "snail_up"
	anim_down = "snail_down"
	anim_left = "snail_left"
	anim_right = "snail_right"

func movimento(delta):
	if (distancia < ATTACK_RANGE - 100): aproximando = -1
	else: aproximando = 1
	
	var motion = aproximando * dir * SPEED * delta
	move(motion)

func attack():	
	add_child(timer)
	timer.set_one_shot(true)
	timer.set_wait_time(3)
	timer.connect("timeout", self, "guspe")
	timer.start()

func guspe():
	timer.stop()
	#HP = 0

func reset():
	timer.stop()
	timer.disconnect("timeout", self, "guspe")
	remove_child(timer)

#func hit(player):
#	.hit(player)
