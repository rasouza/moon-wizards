extends "BaseEnemy.gd"

### PROPRIEDADES #####

const WarmBall = preload("res://game/sprites/enemies/attacks/WarmBall.tscn")

const DAMAGE = 4
const BALL_INTERVAL = 4

var aproximando
var ball_time = 0
var timer
var IMMUNE_TIME = 3
var aux_SPEED

#######################

func _ready():
	HP = 20
	anim_up = "small_worm_up"
	anim_down = "small_worm_down"
	anim_left = "small_worm_left"
	anim_right = "small_worm_right"
	
	timer = Timer.new()
	add_child(timer)
	

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
		else:
			HP -= attack.DAMAGE
			immune = true
			aux_SPEED = SPEED
			SPEED = 0
			animacao.play("immunize")
			
			timer.set_one_shot(true)
			timer.set_wait_time(IMMUNE_TIME)
			timer.connect("timeout", self, "unimmune")
			timer.start()
		
func unimmune():
	timer.disconnect("timeout", self, "unimmune")
	immune = false
	animacao.play("unimmunize")
	
	print("Minhoquinha não está mais imune")

func look_player():
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
	
	SPEED = aux_SPEED

#func hit(player):
#	.hit(player)
