extends Control

var music_player: AudioStreamPlayer
var 少女: AnimatedSprite2D

func set_paused(value: bool):
	visible = value
	GameState.is_game_paused = value
	get_tree().paused = value
	
	if music_player and music_player.is_inside_tree():
		music_player.stream_paused = value
	
	if 少女 and 少女.is_inside_tree():
		if value:
			少女.pause()
		else:
			少女.play()

var _is_paused : bool = false:
	set = set_paused

func _ready():
	_is_paused = false
	call_deferred("_find_少女")

func _find_nodes():
	music_player = get_node_or_null("/root/GameManager/Level1/LevelEditor/DuckMoosic")
	少女 = get_node_or_null("/root/GameManager/Level1/かわいい/少女/AnimatedSprite2D")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause"):
		_is_paused = !_is_paused

func _on_resume_button_pressed() -> void:
	_is_paused = false

func _on_options_button_pressed() -> void:
	if get_tree().get_root().has_node("Options"):
		return
		
	GameState.came_from_pause_menu = true
	Signals.ClearNotes.emit()
	
	visible = false
	
	var options = preload("res://scenes/options.tscn").instantiate()
	options.name = "Options"
	options.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	get_tree().get_root().add_child(options)


func _on_exit_button_pressed() -> void:
	Signals.ClearNotes.emit()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
