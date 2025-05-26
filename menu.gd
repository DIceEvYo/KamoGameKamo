extends Control

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/LevelSelector.tscn")
	
func _on_options_pressed() -> void:
	GameState.came_from_main_menu = true
	var options = preload("res://scenes/options.tscn").instantiate()
	options.name = "Options"
	options.process_mode = Node.PROCESS_MODE_ALWAYS  # Since main menu isn't paused
	get_tree().get_root().add_child(options)

func _on_quit_pressed() -> void:
	get_tree().quit()
