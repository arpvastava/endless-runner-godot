extends Node

enum GameState {
	PLAYING,
	ENDED
}

var player: Player
var camera: Camera3D

signal game_state_changed
var game_state: GameState = GameState.PLAYING:
	get:
		return game_state
	set(value):
		game_state = value
		game_state_changed.emit(game_state)


func _ready() -> void:
	camera = get_viewport().get_camera_3d()
