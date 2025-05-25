extends Control

@onready var music_player = get_node("/root/GameManager/DuckMoosic")

func set_paused(value: bool):
	visible = value
	GameState.is_game_paused = value
	get_tree().paused = value
	music_player.stream_paused = value

var _is_paused : bool = false:
	set = set_paused

func _ready():
	_is_paused = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause"):
		_is_paused = !_is_paused

func _on_resume_button_pressed() -> void:
	_is_paused = false

func _on_options_button_pressed() -> void:
	GameState.came_from_pause_menu = true
	GameState.is_game_paused = true
	
	Signals.ClearNotes.emit()
	get_tree().paused = false
	var options_scene = preload("res://scenes/options.tscn").instantiate()
	get_tree().get_root().add_child(options_scene)
	visible = false

func _on_exit_button_pressed() -> void:
	Signals.ClearNotes.emit()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
