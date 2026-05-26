extends Node

var default_start_position = Vector2(200, 200)

var spawn_position: Vector2 = Vector2.ZERO
var spawn_scene: String = ""

var use_custom_spawn := false

var current_type = "fire"
var defeated_npcs: Array = []
var all_types_collected: Array = ["fire"]
