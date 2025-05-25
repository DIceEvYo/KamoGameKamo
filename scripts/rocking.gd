extends AnimatedSprite2D

var rocking_direction = 1

func _process(delta: float) -> void:
	rotation_degrees += .3 * rocking_direction

func _on_rock_timer_timeout() -> void:
	rocking_direction *= -1
	
