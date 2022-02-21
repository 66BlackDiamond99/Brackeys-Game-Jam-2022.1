extends "res://src/actor/Actor.gd"

onready var dash_timer = $DashTimer
onready var tween = $Tween

var jump_count = 0
var dash_left_count = 0
var dash_right_count = 0

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	var horizontal_move = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = horizontal_move * move_speed.x
	if Input.is_action_just_released("ui_left"):
		dash_timer.start(1)
		dash_right_count = 0
		dash_left_count += 1
		print("DASH COUNT LEFT", dash_left_count)
		if dash_left_count == 2:
			dash_left_count = 0
			_dash_left()
	
	if Input.is_action_just_released("ui_right"):
		dash_timer.start(1)
		dash_right_count += 1
		dash_left_count = 0
		print("DASH COUNT RIGHT", dash_right_count)
		if dash_right_count == 2:
			dash_right_count = 0
			_dash_left()
	
	if Input.is_action_just_pressed("jump"):
		_jump()
	if is_on_floor():
		jump_count = 0
	velocity = move_and_slide(velocity, FLOOR_NORMAL)

func _jump():
	if jump_count < 1:
		jump_count += 1
		velocity.y = -move_speed.y

func _dash_left():
	print("DO THE LEFT DIR DASH")

func _dash_right():
	print("DO THE RIGHT DIR DASH")


func _on_DashTimer_timeout() -> void:
	dash_right_count = 0
	dash_left_count = 0
