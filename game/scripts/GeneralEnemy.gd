extends Sprite

const NENHUMA = 0
const DIREITA = 1
const ESQUERDA = 2
const ACIMA = 3
const ABAIXO = 4

const ATACANDO = 0
const AFASTANDO = 1
const PARALISADO = 2

var veloc_movimento = 100
var veloc_afastamento = 400
var tempo_paralisado = 5
var vetor_vel_afastamento = null

var direcao = NENHUMA
var estado = ATACANDO

var boxEnemy = null
var boxWizard = null

onready var wizard = get_parent().get_node("Wizard")
onready var animacao = get_node("AnimationPlayer")
onready var timer = get_node("Timer")

func _ready():
	self.set_process(true)
	boxEnemy = RectangleShape2D.new()
	boxWizard = RectangleShape2D.new()
	var tamBat = self.get_region_rect().size
	var tamWizard = wizard.get_region_rect().size
	boxEnemy.set_extents(Vector2(tamBat.width, tamBat.height))
	boxWizard.set_extents(Vector2(tamWizard.width, tamWizard.height))
	timer.set_one_shot(true)

func _process(delta):
	if (estado == PARALISADO):
		return
	
	elif (estado == AFASTANDO):
		afastar(delta)

	elif (boxEnemy.collide(get_transform(), boxWizard, wizard.get_transform())):
		self.sofreu_ataque()

	elif (estado == ATACANDO):
		ataque(delta)
	
func ataque(delta):
	var vetor_vel = wizard.get_pos() - self.get_pos()
	vetor_vel = vetor_vel.normalized()
	self.set_pos(self.get_pos() + vetor_vel*delta*veloc_movimento)
	
	var angulo = vetor_vel.angle()
	
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

func afastar(delta):
	self.set_pos(self.get_pos() + vetor_vel_afastamento*delta*veloc_afastamento)

func set_tempo_paralisado(t):
	tempo_paralisado = t

func set_veloc_movimento(v):
	veloc_movimento = v

func sofreu_ataque():
	vetor_vel_afastamento = self.get_pos() - wizard.get_pos()
	vetor_vel_afastamento = vetor_vel_afastamento.normalized()
	estado = AFASTANDO
	timer.set_wait_time(0.15)
	timer.connect("timeout", self, "_timer_afastando")
	timer.start()
	
func _timer_afastando():
	timer.disconnect("timeout", self, "_timer_afastando")
	estado = PARALISADO
	timer.set_wait_time(tempo_paralisado)
	timer.connect("timeout", self, "_timer_paralisado")
	timer.start()

func _timer_paralisado():
	timer.disconnect("timeout", self, "_timer_paralisado")
	estado = ATACANDO