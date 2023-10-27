extends Label

var color = 1

func _process(delta):
	self.modulate.a = color
	
func _on_timer_timeout():
	if color == .6:
		color = 1
	else:
		color = .6
