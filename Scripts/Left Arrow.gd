extends Sprite2D

func _ready():
	self.modulate = Color(0.5,0.5,0.5,0.5)
	
func _physics_process(delta):
	if Global.paddleSelection == 0:
		self.modulate = Color(0.5,0.5,0.5,0.5)
	else:
		self.modulate = Color(1,1,1,1)
