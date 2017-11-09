extends Object

const AttackIceSprite = preload("res://game/sprites/attacks/AttackIceSprite.tscn")

const INTERVAL_WAIT = 2
const INTERVAL_SHOT = 0.3

var wizard
var timer

func _init(wizard):
	self.wizard = wizard
	self.timer = Timer.new()

func attack():
	wizard.add_child(timer)
	timer.set_one_shot(true)
	timer.set_wait_time(INTERVAL_WAIT)
	timer.connect("timeout", self, "apos_espera")
	timer.start()

func apos_espera():
	timer.disconnect("timeout", self, "apos_espera")
	timer.set_one_shot(false)
	timer.set_wait_time(INTERVAL_SHOT)
	timer.connect("timeout", self, "disparo")
	timer.start()

func stop():
	timer.stop()
	timer.disconnect("timeout", self, "apos_espera")
	timer.disconnect("timeout", self, "disparo")
	wizard.remove_child(timer)

func disparo():
	var ice = AttackIceSprite.instance()
	ice.wizard = wizard
	wizard.get_parent().add_child(ice)