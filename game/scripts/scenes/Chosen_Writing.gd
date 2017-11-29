extends Panel

var writings = []

func _ready():
	self.set_process_input(true)
	
	if (Transition.humor == "HATE"):
		writings.push_back("\nCHAPTER ONE: The Burst")
		writings.push_back("\n\" ...")
		writings.push_back("\nBlood demands blood.")
		writings.push_back("\nThat is an universal truth. Those who deny that are fools.")
		writings.push_back("\nPathetic fools.")
		writings.push_back("\nBut I, I am not one of them.")
		writings.push_back("\nI saw all the filth of this disgusting city, all the cruelty, all the inhumanities.")
		writings.push_back("\nAnd now, out of the cold dark jail...I can finally cleanse it.")
		writings.push_back("\nThe jailor is reluctant in letting me out, he...")
		writings.push_back("\n...")
		writings.push_back("\n(The book goes on. You wrote this book with 317 pages)")
		writings.push_back("\n(Congratulations)")
		writings.push_back("")
		
	elif (Transition.humor == "LOVE"):
		writings.push_back("\nCHAPTER ONE: Good Morning!")
		writings.push_back("\n\"The bed feels so warm...I like my bed.")
		writings.push_back("\nMy comfy bed. My daddy made me this bed, he is a woodworker.")
		writings.push_back("\nI love my daddy. I bet he is in the kitchen now, making me breakfast.")
		writings.push_back("\nHmm...maybe some pancakes...or maybe cookies!\"")
		writings.push_back("\n\"Cookies sound nice\". Said a sudden voice.")
		writings.push_back("\n\"Uh? Who said that?\"")
		writings.push_back("\nLisa raised her head, and looked to the window. There was standing a small, blue bird.")
		writings.push_back("\n\"Good morning. Did I scare you, little girl?\"")
		writings.push_back("\n ...")
		writings.push_back("\n(The book goes on. You wrote this book with 115 pages)")
		writings.push_back("\n(Congratulations)")
		writings.push_back("")
		
	elif (Transition.humor == "LOGIC"):
		writings.push_back("\nCHAPTER ONE: Phenomena")
		writings.push_back("\nA flickering torch emits light on to the table.")
		writings.push_back("\nThe books pile up, a reflection of it's owner dedication.")
		writings.push_back("\nStudies on anatomy, dissertations on the ins and outs of the human physique.")
		writings.push_back("\nHuthgard read them all. In years of his seclusion, he perused and absorved thousands of pages.")
		writings.push_back("\nBut as a gutless worm, forever consuming the endless earth, Huthgard still consumed the volumes of his library")
		writings.push_back("\nHe had just completed his last book on his own bed, too focused to pay heed to his own hunger and thirst")
		writings.push_back("\nHuthgard stared at the ceiling. He was meditating, as he does every night.")
		writings.push_back("\n\"Will I ever be able to create a breakthrough? It's been song long since my last discovery...")
		writings.push_back("\nWhy, why heavens why! There must be something else for me to find, something for me to see!")
		writings.push_back("\nMaybe something for me to...invent?...\"")
		writings.push_back("\nA lightning stroke. Not only outside, but within Huthgard mind as well.")
		writings.push_back("\n ...")
		writings.push_back("\n(The book goes on. You wrote this book with 710 pages)")
		writings.push_back("\n(Congratulations)")
		writings.push_back("")
		
	elif (Transition.humor == "POWER"):
		writings.push_back("\n\"CHAPTER ONE: Holy Suplications\"")
		writings.push_back("\nIt was the land of Sulgaria, the land of giants, the land of dragons.")
		writings.push_back("\nA land as vast as the sky, with many perils about, waiting, waiting to be overcome, by the mighty and worthy.")
		writings.push_back("\nNo settlement is too safe, no fortification is too sturdy.")
		writings.push_back("\nAnd this goes too, to the city of Valcum, to the north.")
		writings.push_back("\nThe city of Valcum! Where many heroes gather, where no epic tales go unheard.")
		writings.push_back("\nWhy, this, of course, is one of those stories as well.")
		writings.push_back("\nThis is the story, of Duncan, and the Sword of Fate!")
		writings.push_back("\nDuncan, poor poor boy of the Valcum slums, never had much honor in his life.")
		writings.push_back("\nSating the hunger is not as simple, for the wretched childs of this place.")
		writings.push_back("\nDuncan himself, was alive today, only due to his prowess of thievery.")
		writings.push_back("\nUsing that, also, he had just got the coin purse of a passerby. He would not stay empty-handed today.")
		writings.push_back("\nAs Duncan rummaged through the purse, looking for food and gold, he found a strange item in his hand.")
		writings.push_back("\nHe found himself holding...a glowing gem.")
		writings.push_back("\n ...")
		writings.push_back("\n(The book goes on. You wrote this book with 556 pages)")
		writings.push_back("\n(Congratulations)")
		writings.push_back("")
	
	get_node("TextIndicator").show_text_list(writings)

func _input(event):
	get_node("Sprite/AnimationPlayer").play("flipping")
	if (event.is_action_pressed("ui_accept")): get_node("TextIndicator").next_text()
	if (writings.empty()):
		Transition.fade_to("res://game/scenes/Splash_screen.tscn")