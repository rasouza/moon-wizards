extends Sprite

const SPEED = 100

var dir = Vector2()
var atacando = false
var last_anim = "walk_right"
var active_attack

onready var anim = get_node("WizardAnim")
onready var attack1 = get_node("Attack1")


func _ready():
	active_attack = attack1
	
	self.set_fixed_process(true)
	self.set_process_input(true)
	anim.play(last_anim)

func _input(event):
	if(event.is_action_pressed("ui_right")):
		dir += Vector2(1, 0)
		last_anim = "walk_right"
		anim.play("walk_right")
	if(event.is_action_pressed("ui_left")):
		dir += Vector2(-1, 0)
		last_anim = "walk_left"
		anim.play("walk_left")
	if(event.is_action_pressed("ui_up")):
		dir += Vector2(0, -1)
		last_anim = "walk_up"
		anim.play("walk_up")
	if(event.is_action_pressed("ui_down")):
		dir += Vector2(0, 1)
		last_anim = "walk_down"
		anim.play("walk_down")
	
	if(event.is_action_released("ui_right")):
		dir -= Vector2(1, 0)
	if(event.is_action_released("ui_left")):
		dir -= Vector2(-1, 0)
	if(event.is_action_released("ui_up")):
		dir -= Vector2(0, -1)
	if(event.is_action_released("ui_down")):
		dir -= Vector2(0, 1)
	
	if (event.is_action_pressed("ui_attack")):
		var global_pos = self.get_global_pos()
		var mouse = get_viewport().get_mouse_pos()
		var attack_dir = (mouse - global_pos).normalized()
		if(!atacando):
			anim.play("attack")
		atacando = true
		active_attack.attack()
	
	if (event.is_action_released("ui_attack")):
		atacando = false
		active_attack.stop();

func _fixed_process(delta):
	var motion = dir * SPEED * delta
	set_pos(get_pos() + motion)

func _on_AnimationPlayer_finished():
	if (anim.get_current_animation() == "attack"): anim.play(last_anim)
