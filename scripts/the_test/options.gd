extends Node2D

signal option_pressed

func show_options(option_1, option_2):
	$TwoOptions/Option1.text = option_1
	$TwoOptions/Option2.text = option_2
	$TwoOptions.show()

func _on_two_options_option_1_pressed():
	$TwoOptions.hide()
	emit_signal("option_pressed", "option_1")

func _on_two_options_option_2_pressed():
	$TwoOptions.hide()
	emit_signal("option_pressed", "option_2")
