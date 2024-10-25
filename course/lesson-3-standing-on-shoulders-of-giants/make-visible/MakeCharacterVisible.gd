extends Node2D

@onready var _animation_tree := find_child("AnimationTree")

func _ready():
	_animation_tree.travel("saying_hi")

func _run():
	run()
	await get_tree().create_timer(1.0).timeout
	Events.emit_signal("practice_run_completed")

# EXPORT show
func run():
	show()
# /EXPORT show
