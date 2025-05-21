extends Sprite2D

@export var key_name: String = ""
@onready var falling_key = preload("res://scenes/FallingKey.tscn")

var falling_key_queue = []

func _process(delta):
	if Input.is_action_just_pressed(key_name):
		CreateFallingKey()

func CreateFallingKey():
	var falling_key_scene = falling_key.instantiate()
	get_tree().get_root().call_deferred("add_child", falling_key_scene)
	falling_key_scene.Setup(position.x, key_name)
