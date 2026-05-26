extends CharacterBody2D

@export var weak_against: String = "water"
@export var npc_frame: int = 0
@onready var sprite = $Sprite2D
@onready var interaction_zone = $InteractionZone
@onready var barrier = $Bariera

var player_in_range: bool = false
var my_id: String = ""

func _ready():
	my_id = str(get_path())
	
	if sprite:
		sprite.frame = npc_frame
	if Global.defeated_npcs.has(my_id):
		disable_barrier_instantly()
	if interaction_zone:
		interaction_zone.body_entered.connect(_on_body_entered)
		interaction_zone.body_exited.connect(_on_body_exited)

func _process(_delta):
	if player_in_range and Input.is_key_pressed(KEY_E):
		if Global.current_type == weak_against:
			disable_barrier_instantly()
			if not Global.defeated_npcs.has(my_id):
				Global.defeated_npcs.append(my_id)
				print("Bariera usunięta i zapisana w tej sesji!")

func _on_body_entered(body):
	if body.is_in_group("player"):
		player_in_range = true

func _on_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false
func disable_barrier_instantly():
	if barrier:
		barrier.queue_free()
