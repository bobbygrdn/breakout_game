extends CharacterBody2D

@onready var sprite2D = $Sprite2D
@onready var bluePaddle = preload("res://blue_paddle.tscn")
@onready var greenPaddle = preload("res://green_paddle.tscn")
@onready var redPaddle = preload("res://red_paddle.tscn")
@onready var purplePaddle = preload("res://purple_paddle.tscn")

@export var enableMovement = false

const SPEED = 600.0

var paddleTextures

func _ready():
	paddleTextures = [bluePaddle.instantiate().texture, greenPaddle.instantiate().texture, redPaddle.instantiate().texture, purplePaddle.instantiate().texture]

func _physics_process(delta):
	position.y = 650
	sprite2D.texture = paddleTextures[Global.paddleSelection]
	
	if enableMovement == true:
		movement()

func movement():
	
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

