extends CharacterBody2D

@onready var player = get_node("../Player")
@onready var paddleHitEffect = $PaddleHitEffect
@onready var brickHitEffect1 = $BrickHitEffect1
@onready var brickHitEffect2 = $BrickHitEffect2
@onready var wallHitEffect = $WallHitEffect
@onready var unbreakableHitEffect = $UnbreakableHitEffect

const SPEED = 200.0
const MINSPEED = 1.0
var serveBall = false

signal servedBall

func _ready():
	velocity = Vector2(0,0)

func _physics_process(delta):
	_inputDetection(delta)
	if serveBall == false:
		position.x = player.position.x
	else:
		move(delta)

	var collision_info = move_and_collide(velocity * SPEED * delta)
	if collision_info:
		var collided_body = collision_info.get_collider()
		if collided_body.is_in_group("player"):
			var diff = (global_position.x - player.global_position.x) / (player.get_child(1).shape.get_height()/2)
			if diff != 0:
				velocity = Vector2(diff/2, -velocity.y)
			else:
				velocity = Vector2(1,-velocity.y)
			velocity = velocity.limit_length(SPEED)
			paddleHitEffect.play()
		elif collided_body.is_in_group("wall"):
			velocity = velocity.bounce(collision_info.get_normal())
			wallHitEffect.play()
		elif collided_body.is_in_group("brick"):
			if collided_body.health != 1:
				Global.score += collided_body.health * 5
				Global.newLifeScoreCountdown -= collided_body.health * 5
			else:
				Global.score += 50
				Global.newLifeScoreCountdown -= 50
			collided_body.health -= 1
			velocity = velocity.bounce(collision_info.get_normal())
			randomize()
			var hitSelection = randi_range(1,2)
			if hitSelection == 1:
				brickHitEffect1.play()
			else:
				brickHitEffect2.play()
		elif collided_body.is_in_group("unbreakable"):
			velocity = velocity.bounce(collision_info.get_normal())
			unbreakableHitEffect.play()
	if velocity.length() < MINSPEED:
		velocity = velocity.normalized() * MINSPEED

func reset():
	self.position = Vector2(640,625)
	velocity = Vector2(0,0)
	
func _inputDetection(delta):
	if Input.is_action_just_pressed("ui_select"):
		serveBall = true
		velocity = Vector2(.2,-1).normalized()
		emit_signal("servedBall")

func move(delta):
	position += velocity * SPEED * delta
