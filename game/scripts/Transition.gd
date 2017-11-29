extends CanvasLayer

# STORE THE SCENE PATH
const ir_floresta = 4
const ir_fim = 9

var path = ""
var i = 0
var books_read = 0
var humor


# PUBLIC FUNCTION. CALLED WHENEVER YOU WANT TO CHANGE SCENE
func fade_to(scn_path):
	self.path = scn_path # store the scene path
	get_node("AnimationPlayer").play("fade") # play the transition animation

# PRIVATE FUNCTION. CALLED AT THE MIDDLE OF THE TRANSITION ANIMATION
func change_scene():
	if path != "":
		get_tree().change_scene(path)