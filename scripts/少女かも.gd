extends CharacterBody2D

const GRAVITY = 2700
const JUMP_FORCE = -400

func _physics_process(delta):
	velocity.y += GRAVITY * delta
	move_and_slide()

func _on_timer_timeout() -> void:
	if is_on_floor():
		velocity.y = JUMP_FORCE
