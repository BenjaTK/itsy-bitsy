extends Control


onready var distanceLabel: Label = $DistanceLabel
onready var keybindsSprite: Sprite = $Keybinds


func _process(delta: float) -> void:
	distanceLabel.text = str(round(-Global.player.position.y) + 110)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("button"):
		if keybindsSprite.visible:
			keybindsSprite.hide()
