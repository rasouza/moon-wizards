extends KinematicBody2D

const SmokeSprite = preload("res://game/sprites/attacks/Smoke.tscn")

const DIR = preload("../directions.gd")
const ACT = preload("../actions.gd")
const TYPE = preload("../types.gd")


### PROPRIEDADES ###########

const KNOCKBACK = 15
const ATTACK_COOLDOWN = 0
const DAMAGE = 0
const ATTACK_RANGE = 400
var SPEED = 100
var HP = 0
var immune = false

var anim_up
var anim_down
var anim_left
var anim_right

###########################

var type = TYPE.ENEMY
var direcao = DIR.NENHUMA
var estado = ACT.DESCANSANDO
var dir = Vector2(0,0)
var wizard_pos = Vector2(0,0)
var counter = 0
var distancia

onready var animacao = get_node("Sprite/Animation")
onready var tween = get_node("Tween")
onready var player = get_tree().get_nodes_in_group("player")

func _ready():
	get_node("Area2D").connect("body_enter", self, "_on_body_enter") # Colisor do player
	
	set_fixed_process(true)

func _fixed_process(delta):
	# Verifica se existe um player na cena
	if (player.size() != 0): wizard_pos = player[0].get_global_pos()
	distancia = (wizard_pos - get_global_pos()).length()
	
	if (estado != ACT.PARALISADO):
		if (distancia <= ATTACK_RANGE and !player[0].immune): 
			estado = ACT.ATACANDO
			atacando(delta)
			movimento(delta)
		else:
			if (estado == ACT.ATACANDO): reset()
			estado = ACT.DESCANSANDO
	
	animacao(delta)

func movimento(delta):
	var motion = dir * SPEED * delta
	move(motion)
	
	if (is_colliding()):
        var n = get_collision_normal()
        motion = n.slide(motion)
        move(motion)

func atacando(delta): dir = (wizard_pos - get_global_pos()).normalized()
func andando(delta): pass
	

func animacao(delta):
	var angulo = dir.snapped(Vector2(1,1)) # Gruda o vetor no grid
	if (angulo == Vector2(0,-1) or angulo == Vector2(-1,-1)) and direcao != DIR.CIMA:
		animacao.play(anim_up)
		direcao = DIR.CIMA
	elif (angulo == Vector2(-1,0) or angulo == Vector2(-1,1)) and direcao != DIR.ESQUERDA:
		animacao.play(anim_left)
		direcao = DIR.ESQUERDA
	elif (angulo == Vector2(0,1) or angulo == Vector2(1,1)) and direcao != DIR.BAIXO:
		animacao.play(anim_down)
		direcao = DIR.BAIXO
	elif (angulo == Vector2(1,0) or angulo == Vector2(1,-1)) and direcao != DIR.DIREITA:
		animacao.play(anim_right)
		direcao = DIR.DIREITA

# Depois do knockback o inimigo entra em cooldown
func knockback():
	if (estado == ACT.ATACANDO): reset()
	estado = ACT.PARALISADO
	tween.interpolate_method(self, "move", Vector2(0,0), -dir * KNOCKBACK, 0.05, Tween.TRANS_EXPO, Tween.EASE_OUT)
	tween.start()
	tween.interpolate_callback(self, ATTACK_COOLDOWN, "attack")
	
func attack():
	estado = ACT.ATACANDO

func _on_body_enter( body ): 
	if (body.get("type") != null and body.type == TYPE.ATTACK and body.atacando): 
		get_hit(body)

func hit(player): 
	player.HP -= DAMAGE
	knockback()
	
func get_hit(attack):
	if !immune:
		if (HP <= 0):
			var smoke = SmokeSprite.instance()
			smoke.set_pos(get_pos())
			get_parent().add_child(smoke)
			get_parent().remove_child(self)
			var array = Array()
			array.append(smoke)
			smoke.get_node("AnimationPlayer").connect("finished", self, "destroy_smoke", array)
			smoke.get_node("AnimationPlayer").play("fluff")
			smoke.get_node("SamplePlayer").play("fluff")

func reset():
	estado = estado

func destroy_smoke(smoke):
	smoke.get_parent().remove_child(smoke)