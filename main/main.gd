extends Node3D
class_name Main

@export var ground: CSGBox3D
var ground_mat: StandardMaterial3D
var ground_speed: float = 4


func _ready() -> void:
	ground_mat = ground.material


func _process(delta: float) -> void:
	var new_offset = ground_mat.uv1_offset.z - (ground_speed * delta)
	ground_mat.uv1_offset.z = fmod(new_offset, 1.0)
