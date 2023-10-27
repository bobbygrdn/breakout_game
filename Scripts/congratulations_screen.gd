extends Node

@onready var confirmEffect = $ConfirmEffect
@onready var congratulationsSoundEffect = $CongratulationsSoundEffect

func _process(delta):
	_inputDetection()

func _ready():
	congratulationsSoundEffect.play()
	
func _inputDetection():
	if Input.is_action_just_pressed("ui_accept"):
		confirmEffect.play()
		await confirmEffect.finished
		get_tree().change_scene_to_file("res://record_score_screen.tscn")
