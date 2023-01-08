extends Control


onready var playButton := $"%PlayButton"


func _ready() -> void:
	get_tree().paused = false
	playButton.grab_focus()


func _on_PlayButton_pressed() -> void:
	get_tree().change_scene("res://scenes/main/main.tscn")


func _on_ExitButton_pressed() -> void:
	get_tree().quit()


func _on_InfoButton_pressed() -> void:
	get_tree().change_scene("res://scenes/info screen/info_screen.tscn")
