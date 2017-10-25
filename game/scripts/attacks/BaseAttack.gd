extends KinematicBody2D

const TYPE = preload("../types.gd")

### PROPRIEDADES BASE ####

const DAMAGE = 0
const RANGE = 50

##########################

var type = TYPE.ATTACK
var atacando = false
var attack_dir = null
var wizard_pos = Vector2(0,0)

onready var player = get_tree().get_nodes_in_group("player")
onready var anim = get_node("Sprite/Animation")

func _ready():
	get_node("Area2D").connect("body_enter", self, "_on_body_enter") # Colisor
	set_fixed_process(true)
	
func _fixed_process(delta):
	# Verifica se existe um player na cen
	if (player.size() != 0): wizard_pos = player[0].get_global_pos()

	if (atacando):
		var mouse = get_global_mouse_pos()
		attack_dir = (mouse - wizard_pos).normalized()
		attack_loop(delta)

func attack():
	atacando = true
	show()
	anim.play("attack")
	

func stop():
	hide()
	anim.stop()
	atacando = false

# Particularidades do ataque a ser implementado
func attack_loop(): pass

func hit(enemy):
	enemy.HP -= DAMAGE
	if enemy.HP <= 0:
		enemy.get_parent().remove_child(enemy)

func _on_body_enter(body):
	if (atacando and body.get("type") and body.type == TYPE.ENEMY): hit(body)