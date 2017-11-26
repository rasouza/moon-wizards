extends "BaseEnemy.gd"

### PROPRIEDADES #####

const WarmBall = preload("res://game/sprites/enemies/attacks/WarmBall.tscn")

const DAMAGE = 4
const BALL_INTERVAL = 4

var aproximando
var ball_time = 0

#######################

func _ready():
	HP = 20
	anim_up = "snail_up"
	anim_down = "snail_down"
	anim_left = "snail_left"
	anim_right = "snail_right"

func movimento(delta):
	if (distancia < ATTACK_RANGE - 100): 
		aproximando = -1
		#ball_time += delta
	else: 
		aproximando = 1
		#ball_time = 0
		
	ball_time += delta
		
	if (ball_time > BALL_INTERVAL):
		ball_time = 0
		var ball = WarmBall.instance()
		get_parent().add_child(ball)
		ball.set_pos(get_pos())
	
	var motion = aproximando * dir * SPEED * delta
	move(motion)

#func hit(player):
#	.hit(player)
