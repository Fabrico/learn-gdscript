# Displays a scene inside a frame.
class_name GameView
extends Control

var paused := false: set = set_paused

var _viewport := SubViewport.new()

@onready var _viewport_container = $SubViewportContainer as SubViewportContainer
@onready var _pause_rect := $PauseRect as ColorRect
@onready var _scene_tree := get_tree()


func _ready() -> void:
	_pause_rect.visible = false
	_viewport.name = "SubViewport"
	_viewport_container.add_child(_viewport)
	_scene_tree.connect("screen_resized", Callable(self, "_on_screen_resized"))
	call_deferred("_on_screen_resized")


func toggle_paused() -> void:
	set_paused(not paused)


func set_paused(value: bool) -> void:
	paused = value
	_scene_tree.paused = paused
	_pause_rect.visible = paused


func use_scene(node: Node, viewport_size: Vector2) -> void:
	_viewport.add_child(node)
	_pause_rect.raise()
	_viewport.size = viewport_size


func get_viewport() -> SubViewport:
	return _viewport


func _on_screen_resized() -> void:
	_viewport.size = size
