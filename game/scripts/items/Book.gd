extends KinematicBody2D

const TYPE = preload("../types.gd")
const MUST_READ = 4  # qtd de livros

onready var text_indicator = get_tree().get_nodes_in_group("text_indicator")[0]
onready var player = get_tree().get_nodes_in_group("player")[0]

var type = TYPE.ITEM
var texts = [
	# textos dos livros: colocar aspas: \" dentro da string
	# falas do Mago: basta apenas colocar os textos
	"\"And with the power of the sword, the little Duncan realised that he was nothing.\"",
	"\"Nothing compares to the force of the love, and it can win even fire, ice and thunders.\"",
	"That's a great book! I'm getting inspired.",
	"What kind of horrible book is this? If I keep to read this, I'll unlearn to write.",
]

func _ready():
	get_node("Area2D").connect("body_enter", self, "_on_body_enter")
	
func _on_body_enter( body ): 
	if (body.get("type") != null and body.type == TYPE.PLAYER):
		player.books_read += 1
		hide()
		
		if (player.books_read == MUST_READ):
			Transition.fade_to("res://game/scenes/Writing.tscn")
			return
		
		queue_free()
		text_indicator.show_text(texts[randi() % texts.size()])