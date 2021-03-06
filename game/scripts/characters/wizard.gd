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
var attack_anim
var immune = false
var timer
var delta_count = 0
var alive = true

onready var anim = get_node("Sprite/Animation")
onready var attack1 = get_node("Attacks/Burn")
onready var attack2 = get_node("Attacks/Barrier")
var attack3  # raio não é Node, mas um Object que cria os Nodes
onready var attack4 = get_node("Attacks/Lightning")

onready var text_indicator = get_tree().get_nodes_in_group("text_indicator")[0]

func _ready():
	active_attack = attack1
	
	attack3 = ICE.new(self)
	timer = Timer.new()
	add_child(timer)
	
	self.set_fixed_process(true)
	self.set_process_input(true)
	anim.play("walk_right")

func _input(event):
	if (alive):
		movimento(event)
		ataque(event)
		animacao(event)
		if (event.is_action_pressed("ui_accept")): text_indicator.next_text()

func movimento(event):
	
	if(event.is_action_pressed("ui_right")): dir.x = 1
	if(event.is_action_pressed("ui_left")): dir.x = -1
	if(event.is_action_pressed("ui_up")): dir.y = -1
	if(event.is_action_pressed("ui_down")): dir.y = 1
		
	if(event.is_action_released("ui_right") and dir.x == 1): dir.x = 0
	if(event.is_action_released("ui_left") and dir.x == -1): dir.x = 0
	if(event.is_action_released("ui_up") and dir.y == -1): dir.y = 0
	if(event.is_action_released("ui_down") and dir.y == 1): dir.y = 0
	

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
		
	if (event.is_action_pressed("attack_lightning") and active_attack != attack4):
		active_attack.stop()
		active_attack = attack4
	
	if (event.is_action_pressed("ui_attack")):
		
		if(!atacando):
			if (active_attack == attack3):
				anim.play("attack_ice_start")
			elif (active_attack == attack4):
				anim.play("attack_lightning")
			else:
				anim.play("attack")
		atacando = true
		active_attack.attack()
	
	if (event.is_action_released("ui_attack")):
		
		atacando = false
		attack_anim = null
		active_attack.stop()
		if (active_anims.empty()):
			anim.play("walk_right")
		else:
			anim.play(active_anims.back())

func _fixed_process(delta):
	if (immune and alive): blink(delta)
	
	if(atacando and (active_attack == attack3 or active_attack == attack4)):
		SPEED = 0
	else: SPEED = 100
	var motion = dir.normalized() * SPEED * delta
	move(motion)

	if (is_colliding()):
        var n = get_collision_normal()
        motion = n.slide(motion)
        move(motion)

func _on_AnimationPlayer_finished():
	if (anim.get_current_animation() == "attack"): anim.play("walk_right")

func _on_Area2D_body_enter( body ):
	if(!immune and body.get("type") and body.type == TYPE.ENEMY):
		var old_hp = HP
		body.hit(self)
		if (old_hp > 50 and HP < 50):
			text_indicator.show_text("\nI don't feel so well...")
		if(HP <= 0):
			alive = false
			SPEED = 0
			immune = true
			atacando = false
			attack_anim = null
			active_attack.stop()
			anim.play("die")
		else: immunize()

func blink(delta):
	delta_count += delta
	if(int(delta_count*10)%1 == 0 and get_node("Sprite").is_visible()): get_node("Sprite").hide()
	if(int(delta_count*10)%2 == 0 and not get_node("Sprite").is_visible()): get_node("Sprite").show()

func immunize():
	immune = true
	
	timer.set_one_shot(true)
	timer.set_wait_time(IMMUNE_TIME)
	timer.connect("timeout", self, "unimmune")
	timer.start()

func unimmune():
	timer.disconnect("timeout", self, "unimmune")
	immune = false
	if(not get_node("Sprite").is_visible()): get_node("Sprite").show()
	show()

func GameOver():
	Transition.fade_to("res://game/scenes/GameOver.tscn")