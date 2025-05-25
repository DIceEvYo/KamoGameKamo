extends Control

var came_from_pause_menu: bool = false

func _on_back_pressed() -> void:
	if GameState.came_from_pause_menu:
		get_tree().paused = true
		GameState.came_from_pause_menu = false
		get_parent().visible = true
	else:
		get_tree().change_scene_to_file("res://scenes/menu.tscn")

@onready var volume_slider = %Volume
@onready var mute_checkbox = %Mute

func _on_volume_value_changed(slider_value: float) -> void:
	var bus_index = AudioServer.get_bus_index("Master")

	# If muted, unmute
	if AudioServer.is_bus_mute(bus_index):
		mute_checkbox.button_pressed = false
		AudioServer.set_bus_mute(bus_index, false)

	# Set volume in dB (clamp to -80 if at 0)
	var volume_db = -80.0 if slider_value <= 0.01 else linear_to_db(slider_value)
	AudioServer.set_bus_volume_db(bus_index, volume_db)

func _on_mute_toggled(toggled_on: bool) -> void:
	var bus_index = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_mute(bus_index, toggled_on)
	volume_slider.editable = not toggled_on
