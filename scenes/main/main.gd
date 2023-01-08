extends Node2D



func _ready() -> void:
	get_tree().paused = false


func _on_Player_game_over() -> void:
	get_tree().paused = true
