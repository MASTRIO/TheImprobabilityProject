extends Node2D

@onready var screen_text = $ScreenText
@onready var options = $Options
@onready var flicker_effect = $FlickerEffect

func do_story_stage():
	if Global.current_story_stage == Global.STORY_STAGE.BEFORE_TEST:
		screen_text.clear_text()
		screen_text.add_text_to_buffer("^^^Initialising...")
		screen_text.add_text_to_buffer("Setup Complete.^")
		screen_text.add_text_to_buffer("")
		screen_text.add_text_to_buffer("Welcome user #^667231 to the Improbability Analysis Program")
		screen_text.add_text_to_buffer("Are you ready to begin the test?")
		
		await screen_text.text_buffer_empty
		options.show_options("Yes", "No")
	elif Global.current_story_stage == Global.STORY_STAGE.STARTING_TEST:
		screen_text.add_text_to_buffer("")
		screen_text.add_text_to_buffer("Excellent^")
		screen_text.add_text_to_buffer("The test will now begin")
		await screen_text.text_buffer_empty
		await get_tree().create_timer(2).timeout
		screen_text.clear_text()
		Global.current_story_stage = Global.STORY_STAGE.QUESTION_1
		do_story_stage()
	elif Global.current_story_stage == Global.STORY_STAGE.MISTAKE:
		screen_text.clear_text()
		screen_text.add_text_to_buffer("bruh")
		
		flicker_effect.material.set_shader_parameter("flicker_amount", 3)
		flicker_effect.material.set_shader_parameter("red_amount", 2)
		
		await get_tree().create_timer(2).timeout
		get_tree().quit()
	elif Global.current_story_stage == Global.STORY_STAGE.QUESTION_1:
		screen_text.add_text_to_buffer("Question 1^")
		screen_text.add_text_to_buffer("")
		screen_text.add_text_to_buffer("Who are you")

func _ready():
	do_story_stage()

func _on_options_option_pressed(option):
	if Global.current_story_stage == Global.STORY_STAGE.BEFORE_TEST:
		if option == "option_1":
			Global.current_story_stage = Global.STORY_STAGE.STARTING_TEST
			do_story_stage()
		elif option == "option_2":
			Global.current_story_stage = Global.STORY_STAGE.MISTAKE
			do_story_stage()
