extends Node3D
class_name Main

@export_group("UI")
@export var start_btn: Button
@export var play_again_btn: Button

@export_group("Gameplay")
@export var ground: CSGBox3D
var ground_mat: StandardMaterial3D
var ground_speed: float = 4


func _ready() -> void:
	Global.game_state_changed.connect(_on_game_state_changed)
	start_btn.pressed.connect(_on_start_btn_pressed)
	play_again_btn.pressed.connect(_on_play_again_btn_pressed)
	
	ground_mat = ground.material
	_update_ui()


func _process(delta: float) -> void:
	if Global.game_state == Global.GameState.START:
		pass
	
	elif Global.game_state == Global.GameState.PLAYING:
		var new_offset = ground_mat.uv1_offset.z - (ground_speed * delta)
		ground_mat.uv1_offset.z = fmod(new_offset, 1.0)
	
	elif Global.game_state == Global.GameState.ENDED:
		pass


func _on_game_state_changed(_game_state: Global.GameState) -> void:
	_update_ui()


func _update_ui() -> void:
	start_btn.visible = Global.game_state == Global.GameState.START
	play_again_btn.visible = Global.game_state == Global.GameState.ENDED


func _on_start_btn_pressed() -> void:
	Global.game_state = Global.GameState.PLAYING


func _on_play_again_btn_pressed() -> void:
	Global.game_state = Global.GameState.PLAYING
