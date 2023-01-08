extends KinematicBody2D


const RAY_DISTANCE = 8

export var speed := 75

var dir := Vector2.RIGHT

onready var raycast: RayCast2D = $RayCast2D


func _physics_process(delta: float) -> void:
	if raycast.is_colliding():
		dir = -dir
		raycast.cast_to = dir * RAY_DISTANCE

	move_and_slide(dir * speed)
