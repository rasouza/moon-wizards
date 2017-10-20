extends KinematicBody2D

const DIR = preload("../directions.gd")
const ACT = preload("../actions.gd")
const TYPE = preload("../types.gd")


### PROPRIEDADES ###########

const SPEED = 100
const KNOCKBACK = 10
const ATTACK_COOLDOWN = 5
const DAMAGE = 0

###########################

var type = TYPE.ENEMY
var direcao = DIR.NENHUMA
var estado = ACT.ATACANDO
var dir = Vector2(0,0)
var wizard_pos = Vector2(0,0)

onready var animacao = get_node("Sprite/Animation")
onready var tween = get_node("Tween")
onready var player = get_tree().get_nodes_in_group("player")

func _ready():
	get_node("Area2D").connect("body_enter", self, "_on_Area2D_body_enter") # Colisor do player
	get_node("Area2D").connect("area_enter", self, "_on_Area2D_area_enter") # Colisor do ataque
	
	set_fixed_process(true)

func _fixed_process(delta):
	# Verifica se existe um player na cena
	if (player.size() != 0): wizard_pos = player[0].get_global_pos()
	dir = (wizard_pos - get_global_pos()).normalized()
	
	if (estado == ACT.ATACANDO): 
		movimento(delta)
		animacao(delta)
	
func movimento(delta):
	var motion = dir * SPEED * delta
	move(motion)

func animacao(delta):
	var angulo = dir.snapped(Vector2(1,1)) # Gruda o vetor no grid
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

func _on_Area2D_body_enter( body ): 
	if (body.type == TYPE.PLAYER): hit(body)

func _on_Area2D_area_enter( area ): 
	var body = area.get_parent()
	if (body.type == TYPE.ATTACK): get_hit(body)
	knockback()
	
func hit(player): player.HP -= DAMAGE
func get_hit(attack): HP -= attack.DAMAGE
	