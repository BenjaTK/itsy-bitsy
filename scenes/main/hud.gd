extends Control


onready var distanceLabel = $DistanceLabel


func _process(delta: float) -> void:
	distanceLabel.text = str(round(-Global.player.position.y) + 110)
