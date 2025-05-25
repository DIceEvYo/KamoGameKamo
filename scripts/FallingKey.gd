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

var move_direction: Vector2
var pass_position: Vector2

func _init():
	set_process(false)

func _process(delta):
	global_position += move_direction * fall_speed * delta
	
	if not $Timer.is_stopped() and global_position.distance_to(pass_position) < 20:
		#print($Timer.wait_time - $Timer.time_left)
		$Timer.stop()
		has_passed = true


func Setup(target_pos: Vector2, direction: String):
	match direction:
		"ui_left":
			texture = left
			global_position = Vector2(-100, target_pos.y)
			move_direction = Vector2(1, 0)
			pass_position = Vector2(target_pos.x, target_pos.y)
		"ui_right":
			texture = right
			global_position = Vector2(1280, target_pos.y)
			move_direction = Vector2(-1, 0)
			pass_position = Vector2(target_pos.x, target_pos.y)
		"ui_up":
			texture = up
			global_position = Vector2(target_pos.x, -100)
			move_direction = Vector2(0, -1)
			pass_position = Vector2(target_pos.x, target_pos.y)
		"ui_down":
			texture = down
			global_position = Vector2(target_pos.x, 720)
			move_direction = Vector2(0, -1)
			pass_position = Vector2(target_pos.x, target_pos.y)
			
	set_process(true)


func _on_destroy_timer_timeout():
	queue_free()
