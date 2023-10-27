extends StaticBody2D

@onready var blueBrick = preload("res://blue_brick.tscn")
@onready var redBrick = preload("res://red_brick.tscn")
@onready var greenBrick = preload("res://green_brick.tscn")
@onready var purpleBrick = preload("res://purple_brick.tscn")
@onready var goldBrick = preload("res://gold_brick.tscn")
@onready var blackBrick = preload("res://black_brick.tscn")
@onready var sprite2D = $Sprite2D

@export var health = 1
var bricks

signal death

func _ready():
	randomize()
	health = randi_range(1,5)
	bricks = [blueBrick.instantiate().texture, greenBrick.instantiate().texture, redBrick.instantiate().texture, purpleBrick.instantiate().texture, goldBrick.instantiate().texture]
	sprite2D.texture = bricks[health-1]
	
func _physics_process(delta):
	sprite2D.texture = bricks[health-1]
	
	if health == 0:
		emit_signal("death")
		queue_free()
