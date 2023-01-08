extends Node


var player: Player
var currentCamera: Camera2D


func get_files_in_folder(folderPath: String, fileExtension := "") -> Array:
	var files = []
	var dir = Directory.new()
	dir.open(folderPath)
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with(".") and file.ends_with(fileExtension):
			files.append(file)

	dir.list_dir_end()

	return files


func frame_freeze(timeScale: float, duration: float) -> void:
	Engine.time_scale = timeScale
	yield(get_tree().create_timer(duration * timeScale), "timeout")
	Engine.time_scale = 1.0
