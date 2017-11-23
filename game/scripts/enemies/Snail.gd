extends "BaseEnemy.gd"

### PROPRIEDADES #####

#const AttackSpitSprite = preload("res://game/sprites/attacks/AttackSpitSprite.tscn")
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
	print("\n\nFucking testing")
	print(HP)
	tween.interpolate_callback(self, 3, "guspe")
	#tween.start()
	#tween.set_repeat(true)
	
	#add_child(timer)
	#timer.set_one_shot(false)
	#timer.set_wait_time(3)
	#timer.connect("timeout", self, "guspe")
	#timer.start()

func guspe():
	print(HP)
	HP = 0
	print(HP)
#	disparo()

#func disparo():
#	var guspe = AttackSpitSprite.instance()
#	guspe.wizard = wizard
#	guspe.ref_dir = dir
#	wizard.get_parent().add_child(guspe)
#	sample_player.play("shot")

func reset():
	timer.stop()
	timer.disconnect("timeout", self, "guspe")
	remove_child(timer)

#func hit(player):
#	.hit(player)
