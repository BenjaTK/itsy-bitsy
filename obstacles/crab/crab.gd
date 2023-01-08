extends KinematicBody2D


export var speed := 30
export var jumpHeight := 128
export var gravity := 200

var dir := 1
var velocity := Vector2.ZERO
var isJumping = false

onready var sprite := $Sprite
onready var raycastHolder := $RayCastHolder
onready var raycast: RayCast2D = $RayCastHolder/RayCast2D
onready var jumpTimer: Timer = $JumpTimer
onready var sfxJump: AudioStreamPlayer2D = $SFXJump


func _ready() -> void:
	randomize()
	jumpTimer.wait_time += randf()
	jumpTimer.start()



func _physics_process(delta: float) -> void:
	velocity = move_and_slide(velocity, Vector2.UP)
	if !raycast.is_colliding() and !isJumping:
		dir = -dir

	raycastHolder.scale.x = dir

	if is_on_floor() and isJumping:
		isJumping = false
		print("a")
	if !is_on_floor():
		velocity.y += gravity * delta

	if !isJumping:
		sprite.frame = 0
		velocity.x = dir * speed
	else:
		sprite.frame = 1
		velocity.x = 0



func _on_JumpTimer_timeout() -> void:
	sfxJump.play()
	isJumping = true
	velocity.y = -jumpHeight
	jumpTimer.start()
