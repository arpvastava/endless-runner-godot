extends Node3D
class_name ObstaclesManager

@export_group("External")
@export var obstacles_container: Node3D

@export_group("Internal")
@export var obstacle_scene: PackedScene
@export var spawn_timer: Timer
var offset: float = 2


func _ready() -> void:
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)


func _create_obstacle(x: float) -> void:
	var obstacle: Obstacle = obstacle_scene.instantiate()
	obstacles_container.add_child(obstacle)
	obstacle.position.x = x


func _on_spawn_timer_timeout() -> void:
	# Generate positions
	var exclude_idx: int = randi_range(-1, 1)
	
	var pos_1: float = offset
	var pos_2: float = -offset
	
	if exclude_idx == -1:
		pos_1 = 0
		pos_2 = offset
	elif exclude_idx == 1:
		pos_1 = -offset
		pos_2 = 0
	
	# Create obstacles
	_create_obstacle(pos_1)
	_create_obstacle(pos_2)
