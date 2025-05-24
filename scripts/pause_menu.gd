extends Control

var _is_paused : bool = false:
	set = set_paused

func _ready():
	_is_paused = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause"):
		_is_paused = !_is_paused
	
func set_paused(value : bool):
	_is_paused = value
	get_tree().paused = _is_paused
	visible = _is_paused

func _on_resume_button_pressed() -> void:
	_is_paused = false

func _on_options_button_pressed() -> void:
	_is_paused = false
	get_tree().change_scene_to_file("res://scenes/options.tscn")

func _on_exit_button_pressed() -> void:
	_is_paused = false
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
