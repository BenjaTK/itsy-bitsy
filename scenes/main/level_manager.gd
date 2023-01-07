class_name LevelManager
extends Node2D


const PARTS_FOLDER_PATH = "res://scenes/level parts/"

onready var partsScenesList: Array = _get_parts_scenes_list()

var playerCurrentPart = null setget _set_player_current_part

var partsPlaced : Array
var maxPartsAmount := 6


func _ready() -> void:
	randomize()
	for i in 2:
		_place_random_part_on_front()


func _delete_last_part() -> void:
	var lastPart = partsPlaced.pop_front()
	print(lastPart)
	lastPart.queue_free()


func _on_player_entered_part(newPart) -> void:
	if partsPlaced.size() > maxPartsAmount:
		_delete_last_part()
	_place_random_part_on_front()


func _place_random_part_on_front() -> void:
	partsScenesList.shuffle()
	var newPart = load(PARTS_FOLDER_PATH + partsScenesList[0]).instance()
	if !partsPlaced.empty():
		newPart.position.y = partsPlaced.back().position.y - 128

	partsPlaced.append(newPart)
	call_deferred("add_child", newPart)


func _get_parts_scenes_list() -> Array:
	return Global.get_files_in_folder(PARTS_FOLDER_PATH, "tscn")


func _set_player_current_part(value) -> void:
	playerCurrentPart = value
	_on_player_entered_part(value)
