extends KinematicBody2D


export var speed := 60

var dir := Vector2.LEFT


func _ready() -> void:
	scale.x = -dir.x


func _physics_process(delta: float) -> void:
	move_and_slide(dir * speed)
	if get_slide_count() > 0:
		queue_free()


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
