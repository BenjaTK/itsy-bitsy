extends Node2D


onready var sprite: Sprite = $Sprite

var rng := RandomNumberGenerator.new()


func _ready() -> void:
	rng.randomize()
	sprite.frame = rng.randi_range(0, sprite.hframes - 1)
	print(sprite.frame)
