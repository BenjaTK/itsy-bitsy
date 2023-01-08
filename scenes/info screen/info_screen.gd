extends Control


onready var mainMenuButton := $MainMenuButton


func _ready() -> void:
	mainMenuButton.grab_focus()


func _on_MainMenuButton_pressed() -> void:
	get_tree().change_scene("res://scenes/main menu/main_menu.tscn")
