extends Control

# perfect ffbe00
# great e2dd25
# good a7dd25
# ok 8dbfc7
# miss 5a5758

func SetTextInfo(text: String):
	$ScoreLevelText.text = "[center]" + text
	
	match text:
		"PERFECT":
			$ScoreLevelText.set("theme_override_colors/default_color", Color("ffbe00"))
		"GREAT":
			$ScoreLevelText.set("theme_override_colors/default_color", Color("e2dd25"))
		"GOOD":
			$ScoreLevelText.set("theme_override_colors/default_color", Color("a7dd25"))
		"OK":
			$ScoreLevelText.set("theme_override_colors/default_color", Color("8dbfc7"))
		_:
			$ScoreLevelText.set("theme_override_colors/default_color", Color("5a5758"))
			

func _appear_at(world_pos: Vector2) -> void:
	var canvas_pos = get_viewport().get_canvas_transform() * world_pos
	position = canvas_pos + Vector2(0, -20)
	$AnimationPlayer.play("fall")

	var tween = create_tween()
	tween.tween_property(self, "position", position + Vector2(0, 10), 0.5)
	tween.tween_property(self, "modulate:a", 0.0, 0.5)
	tween.tween_callback(Callable(self, "queue_free"))
