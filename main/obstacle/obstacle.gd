extends Area3D
class_name Obstacle

const speed: float = 20


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _process(delta: float) -> void:
	position.z -= speed * delta


func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		print("Game Over")
