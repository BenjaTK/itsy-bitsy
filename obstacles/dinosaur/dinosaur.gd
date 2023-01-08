extends Node2D


export var dir := Vector2.LEFT

onready var bulletSpikeScene := load("res://obstacles/dinosaur/bullet_spike.tscn")
onready var spikeSpawnPos := $SpikeSpawnPosition
onready var fireRateTimer : Timer = $FireRate
onready var sfxShoot : AudioStreamPlayer2D = $SFXShoot


func _ready() -> void:
	randomize()
	fireRateTimer.wait_time += randf()
	scale.x = -dir.x
	fireRateTimer.start()


func _shoot() -> void:
	var bulletSpike = bulletSpikeScene.instance()
	bulletSpike.global_position = spikeSpawnPos.global_position
	bulletSpike.dir = dir
	get_tree().current_scene.add_child(bulletSpike)
	sfxShoot.play()


func _on_FireRate_timeout() -> void:
	_shoot()
	fireRateTimer.start()



