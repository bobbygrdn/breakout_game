extends Node

@onready var player = $Player
@onready var brickContainer = $"Brick Container"
@onready var ball = preload("res://ball.tscn")
@onready var newBall
@onready var hurtSoundEffect = $HurtSoundEffect
@onready var extraLifeSoundEffect = $ExtraLifeSoundEffect
@onready var highscoreSoundEffect = $HighscoreSoundEffect
@onready var victorySoundEffect = $VictorySoundEffect
@onready var directions = $Directions

var highscores = []
var currentHighscoreToBeat = 9

func _ready():
	player.enableMovement = true
	loadBall()
	for i in range(10):
		highscores.append(HighscoresTracker.scores[i]['score'])

func _physics_process(delta):
	if Global.newLifeScoreCountdown <= 0 && Global.playerHealth < 3:
		Global.playerHealth += 1
		Global.newLifeScoreCountdown = 3000
		extraLifeSoundEffect.play()
	
	if Global.playerHealth == 0:
		redirectPlayer()
	
	if Global.score > HighscoresTracker.scores[currentHighscoreToBeat]['score']:
		if currentHighscoreToBeat != -1:
			playHighscoreSoundEffect()
			currentHighscoreToBeat -= 1

func _on_area_2d_body_entered(body):
	hurtSoundEffect.play()
	Global.playerHealth -= 1
	newBall.queue_free()
	loadBall()
	directions.modulate.a = 1
	

func _on_brick_container_empty():
	Global.level += 1
	
	if Global.level == 6:
		get_tree().change_scene_to_file("res://congratulations_screen.tscn")
	else:
		victorySoundEffect.play()
		await victorySoundEffect.finished
		get_tree().reload_current_scene()
	
func loadBall():
	call_deferred("_loadBall")

func _loadBall():
	newBall = ball.instantiate()
	newBall.connect("servedBall", servedBall)
	newBall.position = Vector2(640,620)
	add_child(newBall)

func servedBall():
	directions.modulate.a = 0

func redirectPlayer():
	if Global.score > HighscoresTracker.scores[9]['score']:
		get_tree().change_scene_to_file("res://record_score_screen.tscn")
	else:
		get_tree().change_scene_to_file("res://game_over_screen.tscn")

func playHighscoreSoundEffect():
	highscoreSoundEffect.play()
