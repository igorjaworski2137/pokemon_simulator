extends CharacterBody2D

@export var npc_frame: int = 0
@onready var sprite = $Sprite2D

var player_in_range: bool = false

func _ready():
	if sprite:
		sprite.frame = npc_frame

func _unhandled_input(event):
	if player_in_range and event.is_action_pressed("interact"):
		if Global.all_types_collected.size() == 7:
			print("Wygrana!")
			get_tree().change_scene_to_file("res://scenes/start/startScene.tscn")
		else:
			print("Przegrałes :(")
			get_tree().quit()

func _on_interaction_zone_body_entered(body):
	if body.is_in_group("player"):
		player_in_range = true

func _on_interaction_zone_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false
