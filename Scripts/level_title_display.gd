extends Label

@onready var timer = $Timer

func _on_timer_timeout():
	self.modulate.a = 0
