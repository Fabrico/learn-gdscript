@tool
# Obstacle
extends Area2D

signal reached_destination

var _tween := Tween.new()
@onready var sprite := $Sprite2D as Sprite2D
@onready var collision_shape := $CollisionShape2D as CollisionShape2D

var speed := 1.0: get = get_velocity, set = set_velocity
@export var texture: Texture2D: get = get_texture, set = set_texture
@export var shape: Shape2D: get = get_shape, set = set_shape


func _init() -> void:
	add_to_group("obstacles")


func _ready() -> void:
	add_child(_tween)
	_tween.connect("tween_all_completed", Callable(self, "_on_Tween_tween_all_completed"))


func set_destination(position_x: float, time := 4.0) -> void:
	_tween.interpolate_property(self, "global_position:x", global_position.x, position_x, time)
	_tween.start()


func _on_Tween_tween_all_completed() -> void:
	emit_signal("reached_destination")
	queue_free()


func set_texture(new_texture: Texture2D) -> void:
	texture = new_texture
	if not is_inside_tree():
		await self.ready
	sprite.texture = texture


func get_texture() -> Texture2D:
	if not is_inside_tree():
		return texture
	return sprite.texture


func set_shape(new_shape: Shape2D) -> void:
	shape = new_shape
	if not is_inside_tree():
		await self.ready
	collision_shape.shape = shape


func get_shape() -> Shape2D:
	if not is_inside_tree():
		return shape
	return collision_shape.shape


func set_velocity(new_speed: float) -> void:
	speed = new_speed
	if not is_inside_tree():
		await self.ready
	_tween.playback_speed = speed


func get_velocity() -> float:
	if not is_inside_tree():
		return speed
	return _tween.playback_speed
