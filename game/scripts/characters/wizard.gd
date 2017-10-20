extends KinematicBody2D

const TYPE = preload("../types.gd")

### PROPRIEDADES ######

const SPEED = 100
var HP = 100

#######################

var type = TYPE.PLAYER
var dir = Vector2()
var atacando = false
var last_anim = "walk_right"
var active_anim = "walk_right"
var active_attack

onready var anim = get_node("Sprite/Animation")
onready var attack1 = get_node("Attacks/Burn")
onready var attack2 = get_node("Attacks/Barrier")

func _ready():
	active_attack = attack1
	
	self.set_fixed_process(true)
	self.set_process_input(true)
	anim.play(last_anim)

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

func animacao(event):
	if(event.is_action_pressed("ui_right")):
		last_anim = active_anim
		active_anim = "walk_right"
		anim.play(active_anim)
		
	if(event.is_action_pressed("ui_left")):
		last_anim = active_anim
		active_anim = "walk_left"
		anim.play(active_anim)
		
	if(event.is_action_pressed("ui_up")):
		last_anim = active_anim
		active_anim = "walk_up"
		anim.play(active_anim)
		
	if(event.is_action_pressed("ui_down")):
		last_anim = active_anim
		active_anim = "walk_down"
		anim.play(active_anim)
		
	if(event.is_action_released("ui_right") and active_anim == "walk_right"):
		active_anim = last_anim
		anim.play(active_anim)
	if(event.is_action_released("ui_left") and active_anim == "walk_left"):
		active_anim = last_anim
		anim.play(active_anim)
	if(event.is_action_released("ui_up") and active_anim == "walk_up"):
		active_anim = last_anim
		anim.play(active_anim)
	if(event.is_action_released("ui_down") and active_anim == "walk_down"):
		active_anim = last_anim
		anim.play(active_anim)

func ataque(event):
	if (event.is_action_pressed("attack_burn")): active_attack = attack1
	if (event.is_action_pressed("attack_barrier")): active_attack = attack2
	
	if (event.is_action_pressed("ui_attack")):
		if(!atacando):
			anim.play("attack")
		atacando = true
		active_attack.attack()
	
	if (event.is_action_released("ui_attack")):
		atacando = false
		active_attack.stop();

func _fixed_process(delta):
	var motion = dir * SPEED * delta
	move(motion)

func _on_AnimationPlayer_finished():
	if (anim.get_current_animation() == "attack"): anim.play(active_anim)