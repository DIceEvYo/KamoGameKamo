extends Sprite2D

@export var key_name: String = ""
@onready var falling_key = preload("res://scenes/FallingKey.tscn")

var falling_key_queue = []

func _process(delta):
	if falling_key_queue.size() > 0:
		if falling_key_queue.front().has_passed:
			falling_key_queue.pop_front()
			#print("popped")
	
	if Input.is_action_just_pressed(key_name):
		var key_to_pop = falling_key_queue.pop_front()
		var distance_from_pass = abs(key_to_pop.pass_threshold - key_to_pop.global_position.y)
		print(distance_from_pass)
		key_to_pop.queue_free()
		
	#11:05 rhythm game tut
	


func CreateFallingKey():
	var falling_key_scene = falling_key.instantiate()
	get_tree().get_root().call_deferred("add_child", falling_key_scene)
	falling_key_scene.Setup(position.x, key_name)
	
	falling_key_queue.push_back(falling_key_scene)


func _on_spawn_timer_timeout() -> void:
	CreateFallingKey()
	$SpawnTimer.wait_time = randf_range(0.4,3)
	$SpawnTimer.start()
