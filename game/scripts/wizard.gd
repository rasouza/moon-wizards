extends Sprite

const DIREITA = 1
const ESQUERDA = 2
const ACIMA = 3
const ABAIXO = 4
const DIREITA_ACIMA = 5
const DIREITA_ABAIXO = 6
const ESQUERDA_ACIMA = 7
const ESQUERDA_ABAIXO = 8

var direcao = DIREITA
var andando = false
var atacando = false
onready var wizard = get_node("Wizard")
onready var fire = get_node("Attack")
onready var wizard_anim = get_node("AnimationPlayer")
onready var fire_anim = get_node("Attack/AnimationPlayer")

func _ready():
	self.set_process(true)
	wizard_anim.play("walk_right")

func _process(delta):
	var pos = self.get_pos()
	
	if (Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_up")):
		pos.x += 1
		pos.y -= 1
		if (!andando || direcao != DIREITA_ACIMA):
			direcao = DIREITA_ACIMA
			wizard_anim.play("walk_right")
			andando = true
	elif (Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_down")):
		pos.x += 1
		pos.y += 1
		if (!andando || direcao != DIREITA_ABAIXO):
			direcao = DIREITA_ABAIXO
			wizard_anim.play("walk_right")
			andando = true
	elif (Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_up")):
		pos.x -= 1
		pos.y -= 1
		if (!andando || direcao != ESQUERDA_ACIMA):
			direcao = ESQUERDA_ACIMA
			wizard_anim.play("walk_left")
			andando = true
	elif (Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_down")):
		pos.x -= 1
		pos.y += 1
		if (!andando || direcao != ESQUERDA_ABAIXO):
			direcao = ESQUERDA_ABAIXO
			wizard_anim.play("walk_left")
			andando = true
	elif (Input.is_action_pressed("ui_right")):
		pos.x += 1
		if (!andando || direcao != DIREITA):
			direcao = DIREITA
			wizard_anim.play("walk_right")
			andando = true
	elif (Input.is_action_pressed("ui_left")):
		pos.x -= 1
		if (!andando || direcao != ESQUERDA):
			direcao = ESQUERDA
			wizard_anim.play("walk_left")
			andando = true
	elif (Input.is_action_pressed("ui_up")):
		pos.y -= 1
		if (!andando || direcao != ACIMA):
			direcao = ACIMA
			wizard_anim.play("walk_up")
			andando = true
	elif (Input.is_action_pressed("ui_down")):
		pos.y += 1
		if (!andando || direcao != ABAIXO):
			direcao = ABAIXO
			wizard_anim.play("walk_down")
			andando = true
	elif (!Input.is_action_pressed("ui_right") &&
		!Input.is_action_pressed("ui_left") &&
		!Input.is_action_pressed("ui_up") &&
		!Input.is_action_pressed("ui_down")):
		andando = false
	
	if (Input.is_action_pressed("ATTACK")):
		var mouse_dir = (get_viewport().get_mouse_pos() - self.get_global_pos()).normalized()
		fire.set_pos(mouse_dir*40)
		
		
		if (!atacando):
			fire.show()
			fire_anim.play("start_Burn")
			atacando = true
			fire.set_frame(0)
			print("Foguinho!")
	
	#if (!Input.is_action_pressed("ATTACK")):
	else:
		fire_anim.stop()
		fire.hide()
		atacando = false
	
	self.set_pos(pos)
