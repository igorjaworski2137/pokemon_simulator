extends Node

var dialogue = []
var current_dialogue_id = 0

func _ready():
	start()

func start():
	dialogue = load_dialogue()
	current_dialogue_id = -1
	next_script()

func load_dialogue():

	var d_file = DialogueData.current_dialogue

	if d_file == "":
		print("Nie wybrano dialogu")
		return []

	if not FileAccess.file_exists(d_file):
		print("Plik nie istnieje")
		return []

	var file = FileAccess.open(d_file, FileAccess.READ)
	if file == null:
		return []

	var parsed = JSON.parse_string(file.get_as_text())

	if parsed == null:
		print("Błąd JSON")
		return []

	return parsed


func _input(event):
	if event.is_action_pressed("interact"):
		next_script()


func next_script():

	current_dialogue_id += 1

	if dialogue == null or dialogue.size() == 0:
		exit_dialog()
		return

	if current_dialogue_id >= dialogue.size():
		exit_dialog()
		return

	$NinePatchRect/Name.text = dialogue[current_dialogue_id]["name"]
	$NinePatchRect/Text.text = dialogue[current_dialogue_id]["text"]
	$NinePatchRect/New.text = dialogue[current_dialogue_id]["type"]
	$NinePatchRect/Current.text = Global.current_type


func exit_dialog():

	DialogueData.current_dialogue = ""

	if Global.spawn_scene != "":
		get_tree().change_scene_to_file(Global.spawn_scene)
	else:
		get_tree().change_scene_to_file("res://scenes/maps/main.tscn")


func _on_change_type_pressed() -> void:
	if current_dialogue_id+1 == dialogue.size():
		print("Zmieniono typ")
		Global.current_type = dialogue[current_dialogue_id]["type"]
		if !Global.all_types_collected.has(dialogue[current_dialogue_id]["type"]):
			Global.all_types_collected.append(Global.current_type)
			print(Global.all_types_collected)
		exit_dialog()
		return
	
func _on_quit_pressed() -> void:
		if current_dialogue_id+1 == dialogue.size():
			exit_dialog()
			return
