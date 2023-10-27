extends HBoxContainer

@onready var firstInitial = $"First Initial"
@onready var secondInitial = $"Second Initial"
@onready var thirdInitial = $"Third Initial"
@onready var selectionEffect = $SelectionEffect
@onready var changeEffect = $ChangeEffect
@onready var confirmEffect = $ConfirmEffect

var firstInitialAscii = 65
var secondInitialAscii = 65
var thirdInitialAscii = 65

var currentInitial = 0
@onready var initials = [firstInitial, secondInitial, thirdInitial]

var color = 1

func _ready():
	var highScoresTracker = get_node("/root/HighscoresTracker")
	highScoresTracker.connect("score_added", on_score_added)

func _process(delta):
	_inputDetection()
	initials[currentInitial].modulate.a = color
	firstInitial.text = char(firstInitialAscii)
	secondInitial.text = char(secondInitialAscii)
	thirdInitial.text = char(thirdInitialAscii)

func _inputDetection():
	if Input.is_action_just_pressed("ui_accept"):
		confirmEffect.play()
		await confirmEffect.finished
		HighscoresTracker.add_score(str(firstInitial.text + secondInitial.text + thirdInitial.text), Global.score)
	if Input.is_action_just_pressed("ui_select"):
		changeEffect.play()
		resetCharacterBlink()
		currentInitial += 1
		if currentInitial > 2:
			currentInitial = 0
	if Input.is_action_just_pressed("ui_down"):
		selectionEffect.play()
		if currentInitial == 0:
			if firstInitialAscii == 65:
				firstInitialAscii = 90
			else:
				firstInitialAscii -= 1
		if currentInitial == 1:
			if secondInitialAscii == 65:
				secondInitialAscii = 90
			else:
				secondInitialAscii -= 1
		if currentInitial == 2:
			if thirdInitialAscii == 65:
				thirdInitialAscii = 90
			else:
				thirdInitialAscii -= 1
	if Input.is_action_just_pressed("ui_up"):
		selectionEffect.play()
		if currentInitial == 0:
			if firstInitialAscii == 90:
				firstInitialAscii = 65
			else:
				firstInitialAscii += 1
		if currentInitial == 1:
			if secondInitialAscii == 90:
				secondInitialAscii = 65
			else:
				secondInitialAscii += 1
		if currentInitial == 2:
			if thirdInitialAscii == 90:
				thirdInitialAscii = 65
			else:
				thirdInitialAscii += 1

func _on_timer_timeout():
	if color == .6:
		color = 1
	else:
		color = .6

func resetCharacterBlink():
	firstInitial.modulate.a = 1
	secondInitial.modulate.a = 1
	thirdInitial.modulate.a = 1

func on_score_added():
	get_tree().change_scene_to_file("res://highscores.tscn")
