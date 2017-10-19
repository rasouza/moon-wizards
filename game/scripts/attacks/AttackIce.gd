extends "BaseAttack.gd"

const INTERVAL = 5 # Tempo entre cada shard

func attack_loop(delta):
	# Implementação: A cada X deltas dispara um shard novo com o attack_dir corrente
	pass

func _on_Area2D_area_enter(area):
	print("Colidiu gelo!")
