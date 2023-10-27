extends Node2D

@onready var level1 = preload("res://Levels/level_1.tscn")
@onready var level2 = preload("res://Levels/level_2.tscn")
@onready var level3 = preload("res://Levels/level_3.tscn")
@onready var level4 = preload("res://Levels/level_4.tscn")
@onready var level5 = preload("res://Levels/level_5.tscn")

signal empty
var bricks

func _ready():
	var levels = [level1, level2, level3, level4, level5]
	var level
	if(Global.level > 5):
		get_tree().change_scene_to_file("res://congratulations_screen.tscn")
	else:
		level = levels[Global.level-1].instantiate()
	add_child(level)
	bricks = get_tree().get_nodes_in_group("brick").size()
	for brick in get_tree().get_nodes_in_group("brick"):
		brick.connect("death", _on_brick_death)

func _physics_process(delta):
	if bricks == 0:
		emit_signal("empty")
	
func _on_brick_death():
	bricks -= 1
