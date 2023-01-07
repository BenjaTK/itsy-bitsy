class_name LevelPart
extends Node2D


onready var playerDetectorArea: Area2D = $PlayerDetectorArea
onready var levelManager: LevelManager = get_parent()


func _ready() -> void:
	playerDetectorArea.connect("body_entered", self, "_on_body_entered")


func _on_body_entered(body: Node) -> void:
	if not (body is Player):
		return

	levelManager.playerCurrentPart = self
