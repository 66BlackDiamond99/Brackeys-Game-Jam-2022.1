extends "res://src/actor/Actor.gd"

func _ready() -> void:
	set_physics_process(false)
	velocity.x = -move_speed.x

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	if is_on_wall():
		velocity.x *= -1.0
	velocity.y = move_and_slide(velocity, FLOOR_NORMAL).y


func _on_HurtBox_area_entered(area: Area2D) -> void:
	print(area)
	if area.is_in_group("Bullet"):
		queue_free()
