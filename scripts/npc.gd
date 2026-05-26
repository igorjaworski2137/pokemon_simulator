extends CharacterBody2D

@export var npc_name = "NPC"
@export_file("*.json") var dialogue_file

var player_inside = false

func _ready():
	$Area2D.body_entered.connect(_on_enter)
	$Area2D.body_exited.connect(_on_exit)

func _on_enter(body):
	if body.is_in_group("player"):
		player_inside = true

func _on_exit(body):
	if body.is_in_group("player"):
		player_inside = false

func _process(delta):
	if player_inside and Input.is_action_just_pressed("interact"):
		interact()

func interact():

	var player = get_tree().get_first_node_in_group("player")

	if player:
		Global.spawn_position = player.global_position
		Global.spawn_scene = get_tree().current_scene.scene_file_path
		Global.use_custom_spawn = true

	DialogueData.current_dialogue = dialogue_file

	get_tree().change_scene_to_file("res://dialogue/dialogue.tscn")
