extends KinematicBody2D

const TYPE = preload("../types.gd")
const INTERVAL_WAIT = 2
const INTERVAL_SHOT = 0.5
const DAMAGE = 10

onready var anim = get_node("Sprite/Animation")
onready var sound = get_node("SamplePlayer")
var type = TYPE.ATTACK
var timer
var area2d
var atacando = false
var enemies = Array()

func _ready():
	set_fixed_process(true)
	timer = Timer.new()
	area2d = get_node("Area2D")
	area2d.connect("body_enter", self, "_on_body_enter")
	area2d.connect("body_exit", self, "_on_body_exit")
	
func attack():
	#enemies = Array()
	add_child(timer)
	timer.set_one_shot(true)
	timer.set_wait_time(INTERVAL_WAIT)
	timer.connect("timeout", self, "comecar_ataque")
	timer.start()
	sound.play("prepare")

func comecar_ataque():
	var mouse = get_parent().get_global_mouse_pos()
	var wizard_pos = get_parent().get_global_pos()
	var attack_dir = (mouse - wizard_pos).normalized()
	var angulo = atan2(attack_dir.x, attack_dir.y) - 1.5
	set_rot(angulo)

	atacando = true
	timer.disconnect("timeout", self, "comecar_ataque")
	timer.set_one_shot(true)
	timer.set_wait_time(INTERVAL_SHOT)
	timer.connect("timeout", self, "parar_ataque")
	timer.start()
	show()
	anim.play("attack")
	sound.play("thunder")

func parar_ataque(): 
	atacando = false
	timer.disconnect("timeout", self, "parar_ataque")
	hide()
	anim.stop()
	attack()  # recomeça
	enemies = Array()

func stop():
	timer.disconnect("timeout", self, "comecar_ataque")
	timer.disconnect("timeout", self, "parar_ataque")
	remove_child(timer)
	hide()
	anim.stop()
	atacando = false

func _fixed_process(delta):
	if (!atacando): return
	for e in enemies:
		e.HP -= DAMAGE
		e.get_hit(self)

func _on_body_enter(body):
	if (body.type == TYPE.ENEMY and body.HP >= 0):
		enemies.append(body)

func _on_body_exit(body):
	if (body.type == TYPE.ENEMY):
		enemies.erase(body)