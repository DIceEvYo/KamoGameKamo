extends Sprite2D

@export var fall_speed: float = 5
var init_y_pos: float = -360
var left = preload("res://assets/sprite/arrows/Left.png")
var right = preload("res://assets/sprite/arrows/Right.png")
var up = preload("res://assets/sprite/arrows/Up.png")
var down = preload("res://assets/sprite/arrows/Down.png")

func _init():
	set_process(false)

func _process(delta):
	global_position += Vector2(0, fall_speed)
	if global_position.y > 509 and not $Timer.is_stopped():
		print($Timer.wait_time - $Timer.time_left)
		$Timer.stop()

func Setup(target_x: float, sprite):
	global_position = Vector2(target_x, init_y_pos)
	if(sprite == "ui_left"): texture = left
	elif(sprite == "ui_up"): texture = up
	elif(sprite == "ui_down"): texture = down
	elif(sprite == "ui_right"): texture = right
	set_process(true)


func _on_destroy_timer_timeout():
	queue_free()
