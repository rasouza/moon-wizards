extends Sprite

var dano = 0

onready var wizard = get_parent()
onready var anim = get_node("AnimationPlayer")
var atacando = false
var attack_dir = null

func _ready():
	set_fixed_process(true)
	
func _fixed_process(delta):
	if (atacando):
		var wizard_pos = wizard.get_global_pos()
		var mouse = get_viewport().get_mouse_pos()
		attack_dir = (mouse - wizard_pos).normalized()
		attack_frame()

func attack():
	atacando = true
	show()
	anim.play("attack")

func stop():
	hide()
	anim.stop()
	atacando = false

func attack_frame():
	pass	