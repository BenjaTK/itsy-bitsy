extends Button


export var normalColor := Color("817d62")
export var hoverColor := Color("f5f1dc")
export var focusColor := Color("f5f1dc")
export var pressedColor := Color("f5edba")


func _ready() -> void:
	modulate = normalColor

	get_viewport().connect("gui_focus_changed", self, "_on_gui_focus_changed")
	connect("mouse_entered", self, "_on_mouse_entered")


func _on_gui_focus_changed(control: Control) -> void:
	if control == self:
		modulate = focusColor
	else:
		modulate = normalColor


func _on_mouse_entered() -> void:
	self.grab_focus()
