extends "res://src/actor/Actor.gd"

onready var anim_sprite = $AnimatedSprite
onready var attack_timer = $AttackTimer
var jump_count = 0
var is_facing_right = true
var attack_available = true

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	if Input.is_action_pressed("ui_left"):
		anim_sprite.play("run")
		if is_facing_right:
			is_facing_right = false
			flip()
		velocity.x = -move_speed.x
	elif Input.is_action_pressed("ui_right"):
		anim_sprite.play("run")
		if !is_facing_right:
			is_facing_right = true
			flip()
		velocity.x = move_speed.x
	else:
		anim_sprite.play("idle")
		velocity.x = 0
	
	if Input.is_action_just_pressed("attack"):
		var bullet = load("res://prefabs/Bullet.tscn").instance()
		bullet.position = $BulletPos.global_position
		bullet.dir = Vector2.RIGHT if is_facing_right else Vector2.LEFT
		get_parent().add_child(bullet)
	if Input.is_action_pressed("jump"):
		_jump()
	
	velocity = move_and_slide(velocity, FLOOR_NORMAL)

func flip():
	scale.x *= -1

func _jump():
	anim_sprite.play("jump")
	if jump_count < 2 || is_on_floor():
		jump_count += 1
		velocity.y = -move_speed.y

func _on_AnimatedSprite_animation_finished():
	if anim_sprite.animation == "jump":
		anim_sprite.play("idle")
