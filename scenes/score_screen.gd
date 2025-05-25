extends Control

@onready var rank_label = $MarginContainer/VBoxContainer/RankLabel
@onready var score_label = $MarginContainer/VBoxContainer/ScoreLabel
@onready var combo_label = $MarginContainer/VBoxContainer/ComboLabel
@onready var retry_button = $MarginContainer/VBoxContainer/RetryButton
@onready var menu_button = $MarginContainer/VBoxContainer/MenuButton

func _ready():
	rank_label.text = "Rank: " + get_rank(GameState.final_score)
	score_label.text = "Score: " + str(GameState.final_score)
	combo_label.text = "Max Combo: " + str(GameState.max_combo)
	
	retry_button.pressed.connect(_on_retry_pressed)
	menu_button.pressed.connect(_on_menu_pressed)
	


func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")


func get_rank(score: int) -> String:
	var target_color: Color
	var return_rank: String

	if score >= 22000:
		target_color = Color("#FFD700")  # Gold
		return_rank = "S"
	elif score >= 19000:
		target_color = Color("#00FFAA")  # Teal
		return_rank = "A"
	elif score >= 15000:
		target_color = Color("#3399FF")  # Light Blue
		return_rank = "B"
	elif score >= 10000:
		target_color = Color("#FF9900")  # Orange
		return_rank = "C"
	else:
		target_color = Color("#FF4444")  # Red
		return_rank = "D"

	# Animate color
	var tween := create_tween()
	var current_color = rank_label.get_theme_color("font_color")
	tween.tween_property(rank_label, "theme_override_colors/font_color", target_color, 0.5).from(current_color)

	# Pop effect
	rank_label.scale = Vector2(1, 1)
	tween.tween_property(rank_label, "scale", Vector2(1.3, 1.3), 0.2)
	tween.tween_property(rank_label, "scale", Vector2(1, 1), 0.2).set_delay(0.2)

	return return_rank
