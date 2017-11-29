extends KinematicBody2D

const TYPE = preload("../types.gd")
const MUST_READ = 4  # qtd de livros

onready var text_indicator = get_tree().get_nodes_in_group("text_indicator")[0]
onready var player = get_tree().get_nodes_in_group("player")[0]
var scene_path = "res://game/scenes/Writing.tscn"


var type = TYPE.ITEM
var texts = [
	# textos dos livros: colocar aspas: \" dentro da string
	# falas do Mago: basta apenas colocar os textos
	#"\n\"And with the power of the sword, the little Duncan realised that he was nothing.\"",
	#"\n\"Nothing compares to the force of the love, and it can win even fire, ice and thunders.\"",
	#"\nThat's a great book! I'm getting inspired.",
	#"\nWhat kind of horrible book is this? If I keep to read this, I'll unlearn to write.",
	
	["\n\"Tyranny\",\n\n by Orgeo Gwell...", "\nI once heard that much blood was shed over the ideas of this book..."],
	["\n\"A Fantasy in the Sun\",\n\n by L. Branf Kaum...", "\nAh, a fistful of joy for all ages. I won't mind some of that"],
	["\n\"Mind and Monster\",\n\n by Llesha May...", "\nThought-provoking, I assume. You've captured my interest, Llesha"],
	["\n\"The Tale of Duncan and the Sword of Fate\",\n\n by Mehoros...", "\nEpics carry some sort of power in their words, don't they?", ""],
	["\n\"Tyranny\",\n\n by Orgeo Gwell...", "\nI once heard that much blood was shed over the ideas of this book..."],
	["\n\"A Fantasy in the Sun\",\n\n by L. Branf Kaum...", "\nAh, a fistful of joy for all ages. I won't mind some of that"],
	["\n\"Mind and Monster\",\n\n by Llesha May...", "\nThought-provoking, I assume. You've captured my interest, Llesha"],
	["\n\"The Tale of Duncan and the Sword of Fate\",\n\n by Mehoros...", "\nEpics carry some sort of power in their words, don't they?", ""],
]

var hate_text = ["\n\"Tyranny\",\n\n by Orgeo Gwell...", "\nI once heard that much blood was shed over the ideas of this book..."]
var love_text =["\n\"A Fantasy in the Sun\",\n\n by L. Branf Kaum...", "\nAh, a fistful of joy for all ages. I won't mind some of that"]
var logic_text = ["\n\"Mind and Monster\",\n\n by Llesha May...", "\nThought-provoking, I assume. You've captured my interest, Llesha"]
var power_text = ["\n\"The Tale of Duncan and the Sword of Fate\",\n\n by Mehoros...", "\nEpics carry some sort of power in their words, don't they?"]

func _ready():
	get_node("Area2D").connect("body_enter", self, "_on_body_enter")
	
func _on_body_enter( body ): 
	if (body.get("type") != null and body.type == TYPE.PLAYER):
		Transition.books_read += 1
		hide()
		
		#if (player.books_read == MUST_READ):
		#	Transition.fade_to(scene_path)
		#	return
		
		queue_free()
		#text_indicator.show_text_list(texts[randi() % texts.size()])
		#text_indicator.show_text_list(texts[i])
		
		if (Transition.i == 0 or Transition.i == 4):
			text_indicator.show_text_list(hate_text)
			Transition.i += 1
		elif (Transition.i == 1 or Transition.i == 5):
			text_indicator.show_text_list(love_text)
			Transition.i += 1
		elif (Transition.i == 2 or Transition.i == 6):
			text_indicator.show_text_list(logic_text)
			Transition.i += 1
		elif (Transition.i == 3 or Transition.i == 7):
			text_indicator.show_text_list(power_text)
			Transition.i += 1
		#texts.pop_front()