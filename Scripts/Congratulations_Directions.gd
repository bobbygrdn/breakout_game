extends Label

@onready var color = 1

func _process(delta):
	modulate.a = color

func _on_timer_timeout():
	if color == .6:
		color = 1
	else:
		color = .6
