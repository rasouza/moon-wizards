extends KinematicBody2D

const TYPE = preload("../../types.gd")

### PROPRIEDADES #####

const DAMAGE = 4
const SPEED = 300
const DURATION = 2

onready var anim = get_node("Sprite/Animation")
onready var player = get_tree().get_nodes_in_group("player")[0]

var type = TYPE.ENEMY
var atacando = true
var timer
var direction = null
var HP = -1  # só para seguir a interface do inimigo

#######################

func _ready():
	get_node("Area2D").connect("body_enter", self, "hit")
	set_fixed_process(true)
	anim.play("spin")
	timer = Timer.new()
	add_child(timer)
	timer.set_one_shot(true)
	timer.set_wait_time(DURATION)
	timer.connect("timeout", self, "destroy")
	timer.start()
	
func _fixed_process(delta):
	if (direction == null): 
		direction = (player.get_pos() - get_pos()).normalized()
		
	var inc = direction * SPEED * delta
	set_pos(get_pos() + inc)

func hit(body):
	if (body == player):
		player.HP -= DAMAGE
		destroy()
	if (body.get_name() == "Barrier" and player.atacando == true and player.active_attack == player.get_node("Attacks/Barrier")):
		destroy()

func get_hit(body): pass  # só para seguir a interface do inimigo

func destroy():
	timer.queue_free()
	hide()
	queue_free()