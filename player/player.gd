class_name Player
extends KinematicBody2D


signal game_over

const ACCEL := 0.5
const FRICTION := 0.2

export var maxSpeed := 125
export var idleRotationSpeed := 6.0

var velocity := Vector2.ZERO
var dir := Vector2.UP

var maxWebLength := 25
var lastWebSfxPos := 0.0
var gameOver := false

onready var speed := maxSpeed

onready var webLine: Line2D = $WebHolder/Web
onready var stunTimer: Timer = $StunTimer
onready var invTimer: Timer = $InvulnerabilityTimer
onready var animPlayer: AnimationPlayer = $AnimationPlayer
onready var sfxWeb: AudioStreamPlayer = $SFXWeb
onready var sfxMove: AudioStreamPlayer = $SFXMove
onready var sfxHit: AudioStreamPlayer = $SFXHit
onready var sfxDie: AudioStreamPlayer = $SFXDie


func _enter_tree() -> void:
	Global.player = self


func _exit_tree() -> void:
	Global.player = null


func _ready() -> void:
	webLine.add_point(global_position)


func _physics_process(delta: float) -> void:
	webLine.set_point_position(webLine.get_point_count() - 1, global_position)
	if Input.is_action_just_pressed("button"):
		sfxWeb.play(lastWebSfxPos)
		sfxMove.play()
		webLine.add_point(global_position)
		while webLine.get_point_count() > maxWebLength:
			webLine.remove_point(0)



	if Input.is_action_pressed("button"):
		_accelerate_to_velocity(dir * speed)
	else:
		lastWebSfxPos = sfxWeb.get_playback_position()
		sfxWeb.stop()
		sfxMove.stop()


		if not _is_stunned():
			velocity = Vector2.ZERO
			rotation += delta * (idleRotationSpeed + (Global.currentCamera.speed / 15))
			dir = Vector2.RIGHT.rotated(rotation)


	move_and_slide(velocity)

	if _is_out_of_bounds(16.0):
		_game_over()


func _accelerate_to_velocity(newVelocity: Vector2) -> void:
	velocity.x = lerp(velocity.x, newVelocity.x, ACCEL if newVelocity.x != 0 else FRICTION)
	velocity.y = lerp(velocity.y, newVelocity.y, ACCEL if newVelocity.y != 0 else FRICTION)


func stun() -> void:
	if !invTimer.is_stopped() or _is_stunned():
		return

	Global.frame_freeze(0.05, 0.5)
	sfxHit.play()

	speed = 0
	velocity = Vector2.ZERO

	stunTimer.start()
	animPlayer.play("stunned")


func _is_stunned() -> bool:
	return !stunTimer.is_stopped()


func _on_StunTimer_timeout() -> void:
	speed = maxSpeed
	animPlayer.play("RESET")
	invTimer.start()


func _game_over() -> void:
	if !gameOver:
		gameOver = true
		sfxDie.play()
		yield(sfxDie, "finished")
		emit_signal("game_over")


func _is_out_of_bounds(graceAmount: float) -> bool:
	var viewportSize = get_viewport_rect().size
	var viewportYHalf: float = viewportSize.y / 2
	var camY = Global.currentCamera.global_position.y
	if (position.y > (camY + viewportYHalf + graceAmount)
	or position.y < (camY - viewportYHalf - graceAmount)):
		return true
	return false
