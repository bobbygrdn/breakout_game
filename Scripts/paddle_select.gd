extends Node2D

@onready var leftArrow = $"Left Arrow"
@onready var rightArrow = $"Right Arrow"
@onready var confirmSound = $ConfirmSound
@onready var selectSound = $SelectSound
@onready var noSelectSound = $NoSelectSound

func _process(delta):
	_inputDetection()

func _inputDetection():
	if Input.is_action_just_pressed("ui_left"):
		if Global.paddleSelection != 0:
			Global.paddleSelection = Global.paddleSelection - 1
			selectSound.play()
		else:
			noSelectSound.play()
	if Input.is_action_just_pressed("ui_right"):
		if Global.paddleSelection != 3:
			Global.paddleSelection = Global.paddleSelection + 1
			selectSound.play()
		else:
			noSelectSound.play()
	if Input.is_action_just_pressed("ui_accept"):
		confirmSound.play()
		await confirmSound.finished 
		get_tree().change_scene_to_file("res://game.tscn")
