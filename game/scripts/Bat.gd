extends Sprite

const VEL_BAT = 100

const NENHUMA = 0
const DIREITA = 1
const ESQUERDA = 2
const ACIMA = 3
const ABAIXO = 4

var direcao = NENHUMA

var boxBat = null
var boxWizard = null

onready var wizard = get_parent().get_node("Wizard")
onready var animacao = get_node("AnimationPlayer")

func _ready():
	self.set_process(true)
	boxBat = RectangleShape2D.new()
	boxWizard = RectangleShape2D.new()
	var tamBat = self.get_region_rect().size
	var tamWizard = wizard.get_region_rect().size
	boxBat.set_extents(Vector2(tamBat.width, tamBat.height))
	boxWizard.set_extents(Vector2(tamWizard.width, tamWizard.height))

func _process(delta):
	if (boxBat.collide(get_transform(), boxWizard, wizard.get_transform())):
		# por enquanto, não fazemos nada :)
		return
	
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
