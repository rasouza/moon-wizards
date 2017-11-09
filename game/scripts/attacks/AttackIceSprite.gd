extends KinematicBody2D

const DAMAGE = 2
const DURATION = 1
const TYPE = preload("../types.gd")

onready var anim = get_node("Sprite/Animation")
var timer
var wizard
var direcao
var type = TYPE.ATTACK
var atacando = true  # sempre

func _ready():
	set_fixed_process(true)
	set_pos(wizard.get_pos())
	var mouse = get_global_mouse_pos()
	var wizard_pos = wizard.get_global_pos()
	var ref_dir = (mouse - wizard_pos).normalized()
	var angulo = atan2(ref_dir.x, ref_dir.y) - 1.5
	var y = sin(angulo)
	var x = sqrt(1 - y*y)
	direcao = Vector2(0, 0)
	
	if angulo > -PI/2:
		direcao = Vector2(x, -y)
	else:
		direcao = Vector2(-x, -y)
		
	set_rot(angulo)
	anim.play("attack")
	
	timer = Timer.new()
	add_child(timer)
	timer.set_one_shot(true)
	timer.set_wait_time(DURATION)
	timer.connect("timeout", self, "destruir")
	timer.start()
	
	get_node("Area2D").connect("body_enter", self, "_on_body_enter") # Colisor
	
func _fixed_process(delta):
	var pos = get_pos()
	set_pos(pos + 5 * direcao)
	
func destruir():
	timer.queue_free()
	hide()
	queue_free()

func _on_body_enter(body):
	if (body.get("type") and body.type == TYPE.ENEMY): 
		body.HP -= DAMAGE
		body.get_hit(self)