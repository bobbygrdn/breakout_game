extends VBoxContainer

@onready var startGame = $"Start Game"
@onready var highscores = $Highscores
@onready var highscoresScene = "res://highscores.tscn"
@onready var paddleSelectScene = "res://paddle_select.tscn"
@onready var selectSound = $SelectSound
@onready var confirmSound = $ConfirmSound

var selection = 0
var labels
var scenes

func _ready():
	labels = [startGame, highscores]
	scenes = [paddleSelectScene, highscoresScene]
	labels[selection].label_settings.font_size = 50

func _physics_process(delta):
	_inputDetection()
	startGame.label_settings.font_size = 30
	highscores.label_settings.font_size = 30
	startGame.label_settings.outline_color = Color(1,1,1)
	highscores.label_settings.outline_color = Color(1,1,1)
	labels[selection].label_settings.font_size = 50
	labels[selection].label_settings.outline_color = Color(0,0,1)

func _inputDetection():
	if Input.is_action_just_pressed("ui_up") || Input.is_action_just_pressed("ui_down"):
		if selection == 0:
			selection = 1
		else:
			selection = 0
		selectSound.play()
	if Input.is_action_just_pressed("ui_accept"):
		confirmSound.play()
		await confirmSound.finished 
		get_tree().change_scene_to_file(scenes[selection])
