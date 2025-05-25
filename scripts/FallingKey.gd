extends Sprite2D

#@export var fall_speed: float = 425.46
@export var fall_speed: float = 1000
var init_y_pos: float = -360
var left = preload("res://assets/sprite/arrows/Left.png")
var right = preload("res://assets/sprite/arrows/Right.png")
var up = preload("res://assets/sprite/arrows/Up.png")
var down = preload("res://assets/sprite/arrows/Down.png")

var has_passed: bool = false
var pass_threshold = 509

func _init():
	set_process(false)

func _process(delta):
	global_position += Vector2(0, fall_speed * delta)
	if global_position.y > pass_threshold and not $Timer.is_stopped():
		#print($Timer.wait_time - $Timer.time_left)
		$Timer.stop()
		has_passed = true

func Setup(target_x: float, sprite: String):
	global_position = Vector2(target_x, init_y_pos)
	if(sprite == "ui_left"): texture = left
	elif(sprite == "ui_up"): texture = up
	elif(sprite == "ui_down"): texture = down
	elif(sprite == "ui_right"): texture = right
	set_process(true)


func _on_destroy_timer_timeout():
	queue_free()
