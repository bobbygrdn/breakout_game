extends Node

@onready var confirmEffect = $ConfirmEffect

func _process(delta):
	_inputDetection()

func _inputDetection():
	if Input.is_action_just_pressed("ui_accept"):
		confirmEffect.play()
		await confirmEffect.finished
		get_tree().change_scene_to_file("res://main_menu.tscn")
