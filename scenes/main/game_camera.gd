extends Camera2D


export var minSpeed := 15.0
export var maxSpeed := 35.0
export var speedIncreaseRateMultiplier := 0.3

var startedScroll = false

onready var speed: float = minSpeed setget set_speed


func _enter_tree() -> void:
	Global.currentCamera = self


func _exit_tree() -> void:
	Global.currentCamera = null


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("button") and not startedScroll:
		startedScroll = true


func _physics_process(delta: float) -> void:
	if startedScroll:
		translate(Vector2.UP * speed * delta)
		set_speed(speed + delta * speedIncreaseRateMultiplier)


func set_speed(value: float) -> void:
	speed = clamp(value, minSpeed, maxSpeed)
