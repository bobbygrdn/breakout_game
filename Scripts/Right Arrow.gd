extends Sprite2D
	
func _physics_process(delta):
	if Global.paddleSelection == 3:
		self.modulate = Color(0.5,0.5,0.5,0.5)
	else:
		self.modulate = Color(1,1,1,1)
