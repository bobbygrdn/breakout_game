extends Label

var color = 1
var reverse = false


func _physics_process(delta):
	self.modulate.a = color

func _on_timer_timeout():
	if color == 1:
		color = 0.5
	else:
		color = 1
	
