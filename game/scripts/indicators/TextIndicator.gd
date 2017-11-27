extends Node2D

#const DURATION = 5

onready var contents = get_node("Contents")

var position_on_screen = Vector2(650, 500)
#var timer
var text_list = []

func _ready():
	set_fixed_process(true)
	#timer = Timer.new()

func _fixed_process(delta):
	var offset = -get_parent().get_global_transform_with_canvas().get_origin()
	set_pos(offset + position_on_screen)

func show_text(text):
	contents.clear()
	contents.add_text(text)
	show()
	#add_child(timer)
	#timer.set_one_shot(true)
	#timer.set_wait_time(DURATION)
	#timer.connect("timeout", self, "hide_text")
	#timer.start()

func show_text_list(show_list):
	text_list = show_list
	contents.clear()
	contents.add_text(text_list[0])
	text_list.pop_front()
	show()

func next_text():
	if (text_list.empty()):
		hide()
	else:
		contents.clear()
		contents.add_text(text_list[0])
		text_list.pop_front()
	#timer.disconnect("timeout", self, "hide_text")
	#remove_child(timer)