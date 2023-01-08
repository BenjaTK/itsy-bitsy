extends Control


export var hudPath: NodePath

onready var hud = get_node(hudPath)
onready var finalDistanceLabel: Label = $FinalDistanceLabel
onready var mainMenuButton: Button = $"%MainMenuButton"
onready var restartButton: Button = $"%RestartButton"


func _on_Player_game_over() -> void:
	finalDistanceLabel.text = hud.distanceLabel.text
	show()
	restartButton.grab_focus()



func _on_RestartButton_pressed() -> void:
	get_tree().reload_current_scene()
