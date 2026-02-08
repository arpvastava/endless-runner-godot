extends CharacterBody3D
class_name Player

const speed: float = 20
const offset: float = 2
var targetX: float = 0
var dir: int = 0

var og_collision_layer: int
var og_collision_mask: int

func _enter_tree() -> void:
	Global.player = self


func _ready() -> void:
	Global.game_state_changed.connect(_on_game_state_changed)
	
	og_collision_layer = collision_layer
	og_collision_mask = collision_mask


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


func _on_game_state_changed(game_state: Global.GameState) -> void:
	if game_state == Global.GameState.PLAYING and not is_processing():
		# Reset position
		position.x = 0
		targetX = 0
		
		# Activate player
		set_process(true)
		collision_layer = og_collision_layer
		collision_mask = og_collision_mask
		visible = true
	
	if game_state == Global.GameState.ENDED:
		# Deactivate player
		set_process(false)
		collision_layer = 0
		collision_mask = 0
		visible = false
