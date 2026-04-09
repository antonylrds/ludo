extends Camera2D


@export var target: Node2D 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(_delta: float) -> void:
	if target:
		# Set the camera's position to the target's position
		global_position = target.global_position
