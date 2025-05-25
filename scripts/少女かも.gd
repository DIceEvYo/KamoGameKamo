extends CharacterBody2D

@export var key_name: String = ""
const GRAVITY = 2700
const JUMP_FORCE = -400

func _physics_process(delta):
	velocity.y += GRAVITY * delta
	move_and_slide()

func _on_timer_timeout() -> void:
	if is_on_floor():
		velocity.y = JUMP_FORCE

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.is_action_pressed("ui_left"):
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("bang-1")
		elif event.is_action_pressed("ui_down") || event.is_action_pressed("ui_up"):
			$AnimatedSprite2D.play("front-1")
		elif event.is_action_pressed("ui_right"):
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("bang-1")


func _on_animated_sprite_2d_animation_finished() -> void:
	$AnimatedSprite2D.play("idle-1")
