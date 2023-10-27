extends Label

func _physics_process(delta):
	updateScore()

func updateScore():
	self.text = "Score: " + str(Global.score)
