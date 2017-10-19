extends KinematicBody2D

const DIR = preload("../directions.gd")
const ACT = preload("../actions.gd")

var SPEED = 100
var KNOCKBACK = 10
var ATTACK_COOLDOWN = 5

var direcao
var estado
var dir = Vector2(0,0)
var wizard_pos = Vector2(0,0)

onready var animacao = get_node("Sprite/Animation")
onready var tween = get_node("Tween")
onready var player = get_tree().get_nodes_in_group("player")

func _ready():
	direcao = DIR.NENHUMA
	estado = ACT.ATACANDO
	get_node("Area2D").connect("area_enter", self, "_on_Area2D_area_enter") # Colisor

	set_fixed_process(true)

func _fixed_process(delta):
	if (estado == ACT.ATACANDO): 
		movimento(delta)
		animacao(delta)
	
func movimento(delta):
	# Verifica se existe um player na cena
	if (player.size() != 0): wizard_pos = player[0].get_node("Body").get_global_pos()
	
	dir = (wizard_pos - get_global_pos()).normalized()
	var motion = dir * SPEED * delta
	move(motion)

func animacao(delta):
	var angulo = dir.snapped(Vector2(1,1))
	if (angulo == Vector2(0,-1) or angulo == Vector2(-1,-1)) and direcao != DIR.CIMA:
		animacao.play("fly_up")
		direcao = DIR.CIMA
	elif (angulo == Vector2(-1,0) or angulo == Vector2(-1,1)) and direcao != DIR.ESQUERDA:
		animacao.play("fly_left")
		direcao = DIR.ESQUERDA
	elif (angulo == Vector2(0,1) or angulo == Vector2(1,1)) and direcao != DIR.BAIXO:
		animacao.play("fly_down")
		direcao = DIR.BAIXO
	elif (angulo == Vector2(1,0) or angulo == Vector2(1,-1)) and direcao != DIR.DIREITA:
		animacao.play("fly_right")
		direcao = DIR.DIREITA

# Depois do knockback o inimigo entra em cooldown
func knockback():
	estado = ACT.PARALISADO
	tween.interpolate_method(self, "move", Vector2(0,0), -dir * KNOCKBACK, 0.05, Tween.TRANS_EXPO, Tween.EASE_OUT)
	tween.start()
	tween.interpolate_callback(self, ATTACK_COOLDOWN, "attack")
	
func attack():
	estado = ACT.ATACANDO

func _on_Area2D_area_enter( area ):
	# PRECISA CHECAR SE É UM ATAQUE COLIDINDO
	knockback()