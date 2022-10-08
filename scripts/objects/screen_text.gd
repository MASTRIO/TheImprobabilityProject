extends Label

signal text_buffer_empty

@onready var text_addition_timer = $TextAdditionTimer

const TEXT_SPEEDS = {
	"normal": 0.1,
	"space": 0,
	"full_stop": 0.5,
	"comma": 0.3,
	"manual_delay": 1
}

var text_buffer = []

func clear_text(clear_buffer: bool = true):
	text = ""
	
	if clear_buffer:
		text_buffer = []

func add_text_to_buffer(text: String):
	for character in text:
		text_buffer.append(character)
	text_buffer.append("\n")

func set_text_addition_time():
	var new_wait_time = 0
	
	if text_buffer[0] == " ":
		new_wait_time = TEXT_SPEEDS.space
	elif text_buffer[0] == ".":
		new_wait_time = TEXT_SPEEDS.full_stop
	elif text_buffer[0] == ",":
		new_wait_time = TEXT_SPEEDS.comma
	elif text_buffer[0] == "^":
		new_wait_time = 0
		while text_buffer[0] == "^" and not text_buffer.is_empty():
			new_wait_time += TEXT_SPEEDS.manual_delay
			text_buffer.remove_at(0)
	else:
		new_wait_time = TEXT_SPEEDS.normal
	
	text_addition_timer.wait_time = new_wait_time
	print("Wait time set to: " + str(text_addition_timer.wait_time))

func _on_text_addition_timer_timeout():
	if not text_buffer.is_empty():
		text += text_buffer[0]
		text_buffer.remove_at(0)
		
		if not text_buffer.is_empty():
			set_text_addition_time()

func _physics_process(_delta):
	if text_buffer.is_empty():
		emit_signal("text_buffer_empty")
