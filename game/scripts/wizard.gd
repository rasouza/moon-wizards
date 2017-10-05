extends Sprite

const DIREITA = 1
const ESQUERDA = 2
const ACIMA = 3
const ABAIXO = 4

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
	
	if (Input.is_action_pressed("ui_right")):
		pos.x += 1
		if (!andando || direcao != DIREITA):
			direcao = DIREITA
			wizard_anim.play("walk_right")
			andando = true
	if (Input.is_action_pressed("ui_left")):
		pos.x -= 1
		if (!andando || direcao != ESQUERDA):
			direcao = ESQUERDA
			wizard_anim.play("walk_left")
			andando = true
	if (Input.is_action_pressed("ui_up")):
		pos.y -= 1
		if (!andando || direcao != ACIMA):
			direcao = ACIMA
			wizard_anim.play("walk_up")
			andando = true
	if (Input.is_action_pressed("ui_down")):
		pos.y += 1
		if (!andando || direcao != ABAIXO):
			direcao = ABAIXO
			wizard_anim.play("walk_down")
			andando = true
	if (!Input.is_action_pressed("ui_right") &&
		!Input.is_action_pressed("ui_left") &&
		!Input.is_action_pressed("ui_up") &&
		!Input.is_action_pressed("ui_down")):
		andando = false
	
	if (Input.is_action_pressed("ATTACK")):
		var mouse_dir = (get_viewport().get_mouse_pos() - pos).normalized()
		fire.set_pos(mouse_dir*40)
		
		
		if (!atacando):
			fire.show()
			fire_anim.play("Burn")
			atacando = true
			fire.set_frame(0)
			print("Foguinho!")
	
	if (!Input.is_action_pressed("ATTACK")):
		fire_anim.stop()
		fire.hide()
		atacando = false
	
	self.set_pos(pos)
