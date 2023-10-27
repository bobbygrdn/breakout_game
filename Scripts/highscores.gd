extends Node

@onready var scoresContainer = $Scores
@onready var score = preload("res://score.tscn")
@onready var confirmEffect = $ConfirmEffect

func _ready():
	renderScores()

func _process(delta):
	_inputDetection()

func scoreCreator(place, initials, value):
	var scoreInstance = score.instantiate()
	scoreInstance.find_child("Placement").text = str(place)
	scoreInstance.find_child("Initials").text = initials
	scoreInstance.find_child("Score").text = str(value)
	return scoreInstance

func _inputDetection():
	if Input.is_action_just_pressed("ui_accept"):
		confirmEffect.play()
		await confirmEffect.finished
		get_tree().change_scene_to_file("res://main_menu.tscn")

func renderScores():
	for i in range(10):
		scoresContainer.add_child(scoreCreator(i+1, HighscoresTracker.scores[i]["initials"], HighscoresTracker.scores[i]["score"]))
