extends "BaseAttack.gd"

const INTERVAL = 5 # Tempo entre cada shard
const DAMAGE = 2

var direcao

# inicio do gelo: calcula a direção para todo o seu tempo de
# existência
func attack():
	.attack()
	var mouse = get_global_mouse_pos()
	direcao = (mouse - wizard_pos).normalized()
	set_rot(atan2(direcao.x, direcao.y) - 1.5)
	#set_pos(player[0].get_global_pos())

func attack_loop(delta):
	set_pos(get_pos() + direcao)

func hit(enemy):
	enemy.HP -= DAMAGE

# O gelo não deve parar quando solta o botão do mouse, 
# e sim com um timer
func stop():
	pass