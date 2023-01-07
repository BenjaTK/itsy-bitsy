class_name Player
extends KinematicBody2D


const ACCEL := 0.5
const FRICTION := 0.2

export var speed := 125
export var idleRotationSpeed := 6.0

var velocity := Vector2.ZERO
var dir := Vector2.UP

onready var webLine: Line2D = $WebHolder/Web


func _ready() -> void:
	webLine.add_point(global_position)


func _physics_process(delta: float) -> void:
	webLine.set_point_position(webLine.get_point_count() - 1, global_position)
	if Input.is_action_just_pressed("button"):
		webLine.add_point(global_position)


	if Input.is_action_pressed("button"):
		_accelerate_to_velocity(dir * speed)
	else:
		velocity = Vector2.ZERO
		rotation += delta * idleRotationSpeed
		dir = Vector2.RIGHT.rotated(rotation)


	move_and_slide(velocity)

	if _is_out_of_bounds(16.0):
		_game_over()



func _accelerate_to_velocity(newVelocity: Vector2) -> void:
	velocity.x = lerp(velocity.x, newVelocity.x, ACCEL if newVelocity.x != 0 else FRICTION)
	velocity.y = lerp(velocity.y, newVelocity.y, ACCEL if newVelocity.y != 0 else FRICTION)


func _game_over() -> void:
	print("game over")


func _on_screen_exited() -> void:
	_game_over()


func _is_out_of_bounds(graceAmount: float) -> bool:
	var viewportSize = get_viewport_rect().size
	var viewportYHalf: float = viewportSize.y / 2
	var camY = Global.currentCamera.global_position.y
	if (position.y > (camY + viewportYHalf + graceAmount)
	or position.y < (camY - viewportYHalf - graceAmount)):
		return true
	return false
