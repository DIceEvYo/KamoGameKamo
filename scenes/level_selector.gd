extends Control


func _on_duckageddon_normal_pressed() -> void:
	GameState.current_level_name = "DUCKAGEDDON"
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_duckageddon_hard_pressed() -> void:
	GameState.current_level_name = "DUCKAGEDDON"
	get_tree().change_scene_to_file("res://scenes/game.tscn")
