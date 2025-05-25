extends ColorRect

func fade_in(duration := 1.0):
	modulate.a = 0.0
	show()
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, duration)

func fade_out(duration := 1.0):
	modulate.a = 1.0
	show()
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, duration)
	tween.tween_callback(hide)
