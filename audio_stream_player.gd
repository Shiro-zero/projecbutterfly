extends AudioStreamPlayer

func _ready() -> void:
	self.connect("finished", Callable(self,"_on_loop_sound"))
	self.play()

func _on_loop_sound(player):
	self.stream_paused = false
