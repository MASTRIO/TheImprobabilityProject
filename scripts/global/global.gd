extends Node

enum STORY_STAGE {
	BEFORE_TEST,
	STARTING_TEST,
	MISTAKE,
	QUESTION_1
}
var current_story_stage = STORY_STAGE.BEFORE_TEST