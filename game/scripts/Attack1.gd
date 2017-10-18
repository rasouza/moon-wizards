extends Sprite

var distancia = 50 # Distância entre o mago e o ataque
var dano = 0

onready var wizard = get_parent()
onready var anim = get_node("AnimationPlayer")
var atacando = false

func _ready():
	set_z(-10)
	set_fixed_process(true)
	pass
	
func _fixed_process(delta):
	if (atacando):
		var wizard_pos = wizard.get_global_pos()
		var mouse = get_viewport().get_mouse_pos()
		var attack_dir = (mouse - wizard_pos).normalized()
		set_pos(attack_dir*distancia)

func attack():
	atacando = true
	show()
	anim.play("attack")

func stop():
	hide()
	anim.stop()
	atacando = false