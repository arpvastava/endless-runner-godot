extends Area3D
class_name Obstacle

const speed: float = 20


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _process(delta: float) -> void:
	position.z -= speed * delta
	
	if global_position.z > Global.camera.global_position.z:
		queue_free()


func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		Global.game_state = Global.GameState.ENDED
