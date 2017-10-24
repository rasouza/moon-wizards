extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _physics_process(delta):
	print(delta);
	move(Vector2(0,1))

func _ready():
	self.set_phy
