extends Area2D

@export var target_scene: String
@export var spawn_position: Vector2

func _on_body_entered(body):
	if !body.is_in_group("player"):
		return

	Global.spawn_position = spawn_position
	Global.use_custom_spawn = true

	get_tree().call_deferred("change_scene_to_file", target_scene)
