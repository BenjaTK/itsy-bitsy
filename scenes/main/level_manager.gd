class_name LevelManager
extends Node2D


const PARTS_FOLDER_PATH = "res://scenes/level parts/"

onready var partsScenesList: Array = _get_parts_scenes_list()

var playerCurrentPart = null setget _set_player_current_part
var lastPlacedPart = null

var rng = RandomNumberGenerator.new()


func _ready() -> void:
	rng.randomize()

	_place_part_on_front(load("res://scenes/level parts/level_part_01.tscn").instance())
	_place_random_part_on_front()


func _place_random_part_on_front() -> void:
	var scenePath = partsScenesList[rng.randi_range(0, partsScenesList.size() -1)]
	var randomPart = load(PARTS_FOLDER_PATH + scenePath).instance()
	_place_part_on_front(randomPart)


func _on_player_entered_part(newPart) -> void:
	_place_random_part_on_front()


func _place_part_on_front(newPart) -> void:
	if lastPlacedPart != null:
		newPart.position.y = lastPlacedPart.position.y - 128

	lastPlacedPart = newPart
	call_deferred("add_child", newPart)


func _get_parts_scenes_list() -> Array:
	return Global.get_files_in_folder(PARTS_FOLDER_PATH, "tscn")


func _set_player_current_part(value) -> void:
	playerCurrentPart = value
	_on_player_entered_part(value)
