extends CharacterBody3D
class_name Player

const speed: float = 20
const offset: float = 2
var targetX: float = 0
var dir: int = 0


func _enter_tree() -> void:
	Global.player = self


func _ready() -> void:
	Global.game_state_changed.connect(_on_game_state_changed)


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("left"):
		dir = -1
		
		if targetX == offset:
			targetX = 0
		elif targetX == 0:
			targetX = -offset
	
	elif Input.is_action_just_pressed("right"):
		dir = 1
		
		if targetX == -offset:
			targetX = 0
		elif targetX == 0:
			targetX = offset
	
	if abs(targetX - position.x) < 0.1:
		dir = 0
	
	velocity.x = dir * speed
	move_and_slide()


func _on_game_state_changed(new_state: Global.GameState) -> void:
	if new_state == Global.GameState.ENDED:
		set_process(false)
		collision_layer = 0
		collision_mask = 0
		visible = false
