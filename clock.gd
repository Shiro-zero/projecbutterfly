extends TextureProgressBar

@onready var timer = $Timer

func _process(delta: float) -> void:
	if timer.is_stopped():
		return
	
	value = ((timer.wait_time - timer.time_left) / timer.wait_time) * max_value

func start_timer():
	timer.start()
	value = 0
	
func stop_timer():
	timer.stop()

func is_over():
	return value == max_value
