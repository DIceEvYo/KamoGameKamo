extends Sprite2D

@export var key_name: String = ""
@onready var falling_key = preload("res://scenes/FallingKey.tscn")
@onready var score_text = preload("res://scenes/score_press_text.tscn")

var array_num: int = 0

var falling_key_queue = []

# If distance_from_pass is less than threshold, give that score
var perfect_press_threshold: float = 30
var great_press_threshold: float = 50
var good_press_threshold: float = 60
var ok_press_threshold: float = 80
# otherwise, miss

var perfect_press_score: float = 250
var great_press_score: float = 100
var good_press_score: float = 50
var ok_press_score: float = 20


func _ready() -> void:
	$GlowOverlay.modulate = Color(1, 1, 1, 0)
	Signals.CreateFallingKey.connect(CreateFallingKey)
	
	match key_name:
		"ui_left": array_num = 0
		"ui_down": array_num = 1
		"ui_up": array_num = 2
		"ui_right": array_num = 3

# Called every frame. "delta" is the elapsed time since the previous fram,e
func _process(_delta):
	
	# Make sure there is a falling key to check for this given key
	if falling_key_queue.size() > 0:
		
		# If that falling key has passed, remove it from the queue
		if falling_key_queue.front().has_passed:
			falling_key_queue.pop_front()
			#print("popped")
			
			# PRINT MISS
			var st_inst = score_text.instantiate()
			get_tree().get_root().call_deferred("add_child", st_inst)
			st_inst.SetTextInfo("MISS")
			st_inst.call_deferred("_appear_at", global_position + Vector2(0, -20))
			
	# If key is pressed, pop from the queue and calculate distance from critical point
	if Input.is_action_just_pressed(key_name):
		Signals.KeyListenerPress.emit(key_name, array_num)
		var key_to_pop = falling_key_queue.pop_front()
		
		if key_to_pop != null:
			
			var distance_from_pass = abs(key_to_pop.pass_threshold - key_to_pop.global_position.y)
			
			$AnimationPlayer.stop()
			$AnimationPlayer.play("key_hit")
			
			var press_score_text: String = ""
			
			if distance_from_pass < perfect_press_threshold:
				Signals.IncrementScore.emit(perfect_press_score)
				press_score_text = "PERFECT"
				Signals.IncrementCombo.emit()
			elif distance_from_pass < great_press_threshold:
				Signals.IncrementScore.emit(great_press_score)
				press_score_text = "GREAT"
				Signals.IncrementCombo.emit()
			elif distance_from_pass < good_press_threshold:
				Signals.IncrementScore.emit(good_press_score)
				press_score_text = "GOOD"
				Signals.IncrementCombo.emit()
			elif distance_from_pass < ok_press_threshold:
				Signals.IncrementScore.emit(ok_press_score)
				press_score_text = "OK"
				Signals.IncrementCombo.emit()
			else:
				press_score_text = "MISS"
				Signals.ResetCombo.emit()
			
			key_to_pop.queue_free()
			
			var st_inst = score_text.instantiate()
			get_tree().get_root().call_deferred("add_child", st_inst)
			st_inst.SetTextInfo(press_score_text)
			st_inst.call_deferred("_appear_at", key_to_pop.global_position + Vector2(0, -20))
			#11:05 rhythm game tut


func CreateFallingKey(button_name: String):
	if button_name == key_name:
		var falling_key_scene = falling_key.instantiate()
		get_tree().get_root().call_deferred("add_child", falling_key_scene)
		falling_key_scene.Setup(position.x, key_name)
		
		falling_key_queue.push_back(falling_key_scene)
