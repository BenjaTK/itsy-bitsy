class_name LevelPart
extends Node2D


onready var playerDetectorArea: Area2D = $PlayerDetectorArea
onready var levelManager: LevelManager = get_parent()
onready var visibilityNotifier: VisibilityNotifier2D = $VisibilityNotifier2D


func _ready() -> void:
	playerDetectorArea.connect("body_entered", self, "_on_body_entered")
	visibilityNotifier.connect("screen_exited", self, "_on_screen_exited")


func _on_body_entered(body: Node) -> void:
	if not (body is Player):
		return

	levelManager.playerCurrentPart = self


func _on_screen_exited() -> void:
	queue_free()
