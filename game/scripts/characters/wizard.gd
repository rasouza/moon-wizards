extends KinematicBody2D

const TYPE = preload("../types.gd")
const ICE = preload("../attacks/AttackIce.gd")

### PROPRIEDADES ######

var SPEED
var HP = 100
var IMMUNE_TIME = 3

#######################

var type = TYPE.PLAYER
var dir = Vector2()
var atacando = false
var active_anims = []
var active_attack
var immune = false
var timer

onready var anim = get_node("Sprite/Animation")
onready var attack1 = get_node("Attacks/Burn")
onready var attack2 = get_node("Attacks/Barrier")
var attack3
var attack4

func _ready():
	active_attack = attack1
	
	attack3 = ICE.new(self)
	timer = Timer.new()
	add_child(timer)
	
	self.set_fixed_process(true)
	self.set_process_input(true)
	anim.play("walk_right")

func _input(event):
	movimento(event)
	animacao(event)
	ataque(event)

func movimento(event):
	
	if(event.is_action_pressed("ui_right")): dir += Vector2(1, 0)
	if(event.is_action_pressed("ui_left")): dir += Vector2(-1, 0)
	if(event.is_action_pressed("ui_up")): dir += Vector2(0, -1)
	if(event.is_action_pressed("ui_down")): dir += Vector2(0, 1)
		
	if(event.is_action_released("ui_right")): dir -= Vector2(1, 0)
	if(event.is_action_released("ui_left")): dir -= Vector2(-1, 0)
	if(event.is_action_released("ui_up")): dir -= Vector2(0, -1)
	if(event.is_action_released("ui_down")): dir -= Vector2(0, 1)
		
	if(event.is_action_released("ui_select")):
			get_node("/root/global").goto_scene("res://game/scenes/cena_teste.tscn")

func animacao(event):
	if(event.is_action_pressed("ui_right")):
		active_anims.push_back("walk_right")
		if(not (atacando and (active_attack == attack3 or active_attack == attack4))):
			anim.play(active_anims.back())
		
	if(event.is_action_pressed("ui_left")):
		active_anims.push_back("walk_left")
		if(not (atacando and (active_attack == attack3 or active_attack == attack4))):
			anim.play(active_anims.back())
		
	if(event.is_action_pressed("ui_up")):
		active_anims.push_back("walk_up")
		if(not (atacando and (active_attack == attack3 or active_attack == attack4))):
			anim.play(active_anims.back())
		
	if(event.is_action_pressed("ui_down")):
		active_anims.push_back("walk_down")
		if(not (atacando and (active_attack == attack3 or active_attack == attack4))):
			anim.play(active_anims.back())
		
	if(event.is_action_released("ui_right")):
		active_anims.erase("walk_right")
		if(not (atacando and (active_attack == attack3 or active_attack == attack4)) and not active_anims.empty()):
			anim.play(active_anims.back())
	
	if(event.is_action_released("ui_left")):
		active_anims.erase("walk_left")
		if(not (atacando and (active_attack == attack3 or active_attack == attack4)) and not active_anims.empty()):
			anim.play(active_anims.back())
	
	if(event.is_action_released("ui_up")):
		active_anims.erase("walk_up")
		if(not (atacando and (active_attack == attack3 or active_attack == attack4)) and not active_anims.empty()):
			anim.play(active_anims.back())
	
	if(event.is_action_released("ui_down")):
		active_anims.erase("walk_down")
		if(not (atacando and (active_attack == attack3 or active_attack == attack4)) and not active_anims.empty()):
			anim.play(active_anims.back())

func ataque(event):
	if (event.is_action_pressed("attack_burn") and active_attack != attack1):
		active_attack.stop()
		active_attack = attack1
	
	if (event.is_action_pressed("attack_barrier") and active_attack != attack2):
		active_attack.stop()
		active_attack = attack2
	
	if (event.is_action_pressed("attack_ice") and active_attack != attack3):
		active_attack.stop()
		active_attack = attack3
	
	if (event.is_action_pressed("ui_attack")):
		if(!atacando):
			if (active_attack == attack3):
				anim.play("attack_channel_start")
			else:
				anim.play("attack")
		atacando = true
		active_attack.attack()
	
	if (event.is_action_released("ui_attack")):
		atacando = false
		active_attack.stop()
		if (active_anims.empty()):
			anim.play("walk_right")
		else:
			anim.play(active_anims.back())

func _fixed_process(delta):
	if(atacando and (active_attack == attack3 or active_attack == attack4)):
		SPEED = 0
	else: SPEED = 100
	var motion = dir.normalized() * SPEED * delta
	move(motion)

	if (immune): bright()

	if (is_colliding()):
        var n = get_collision_normal()
        motion = n.slide(motion)
        move(motion)

func _on_AnimationPlayer_finished():
	if (anim.get_current_animation() == "attack"): anim.play("walk_right")

func _on_Area2D_body_enter( body ):
	if(!immune and body.get("type") and body.type == TYPE.ENEMY):
		body.hit(self)
		immunize()

func bright():
	if (is_visible()):
		hide()
	else:
		show()

func immunize():
	immune = true
	timer.set_one_shot(true)
	timer.set_wait_time(IMMUNE_TIME)
	timer.connect("timeout", self, "unimmune")
	timer.start()

func unimmune():
	timer.disconnect("timeout", self, "unimmune")
	immune = false
	show()