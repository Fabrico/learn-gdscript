class_name CodeExampleVariableUnderline
extends Node2D

const LINE_COLOR := Color(1, 0.96, 0.25)
const LINE_WIDTH := 3.0
const TWEEN_DURATION := 0.2

@export var font_resource: Resource

var highlight_rect := Rect2(): set = set_highlight_rect
var variable_name := ""

@onready var _scene_instance: Node
@onready var _mouse_blocker := $MouseBlocker as Control
@onready var _label := $MouseBlocker/Label as Label


func _ready() -> void:
	_mouse_blocker.connect("mouse_entered", Callable(self, "_on_blocker_mouse_entered"))
	_mouse_blocker.connect("mouse_exited", Callable(self, "_on_blocker_mouse_exited"))


func setup(runnable_code, scene_instance: Node) -> void:
	runnable_code.connect("code_updated", Callable(self, "_update_label_text"))
	_scene_instance = scene_instance


func set_highlight_rect(value) -> void:
	highlight_rect = value

	if not is_inside_tree():
		await self.ready

	_mouse_blocker.position = highlight_rect.position
	_mouse_blocker.size = highlight_rect.size


func _update_label_text():
	_label.text = str(_scene_instance.get(variable_name))
	_label.size = _label.get_font("font").get_string_size(_label.text)
	_label.position.x = (_mouse_blocker.size.x / 2 - _label.size.x / 2)


func _on_blocker_mouse_entered():
	_update_label_text()
	_label.show()


func _on_blocker_mouse_exited():
	_label.hide()
