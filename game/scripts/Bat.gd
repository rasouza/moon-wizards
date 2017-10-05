extends Sprite

const VEL_BAT = 100

const NENHUMA = 0
const DIREITA = 1
const ESQUERDA = 2
const ACIMA = 3
const ABAIXO = 4

var direcao = NENHUMA

onready var wizard = get_parent().get_node("Wizard")
onready var animacao = get_node("AnimationPlayer")

func _ready():
	self.set_process(true)

func _process(delta):
	var velocidade = wizard.get_pos() - self.get_pos()
	velocidade = velocidade.normalized()
	self.set_pos(self.get_pos() + velocidade*delta*VEL_BAT)
	
	var angulo = velocidade.angle()
	
	if angulo < -3*PI/4:
		if direcao != ACIMA:
			animacao.play("fly_up")
			direcao = ACIMA
			
	elif angulo < -PI/4:
		if direcao != ESQUERDA:
			animacao.play("fly_left")
			direcao = ESQUERDA
			
	elif angulo < PI/4:
		if direcao != ABAIXO:
			animacao.play("fly_down")
			direcao = ABAIXO
			
	elif angulo < 3*PI/4:
		if direcao != DIREITA:
			animacao.play("fly_right")
			direcao = DIREITA
			
	else:
		if direcao != ACIMA:
			animacao.play("fly_up")
			direcao = ACIMA
