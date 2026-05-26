extends CharacterBody2D

@export var speed = 100

@onready var anim = $AnimatedSprite2D

func _ready():
	add_to_group("player")

	if Global.use_custom_spawn:
		global_position = Global.spawn_position
		Global.use_custom_spawn = false
	else:
		global_position = Global.default_start_position

func _physics_process(delta):
	var direction = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	elif Input.is_action_pressed("move_left"):
		direction.x += -1
	elif Input.is_action_pressed("move_down"):
		direction.y += 1
	elif Input.is_action_pressed("move_up"):
		direction.y += -1

	velocity = direction * speed
	move_and_slide()

	update_animation(direction)

	
func update_animation(direction):
	if direction == Vector2.ZERO:

		anim.stop()
		return
	
	if direction.x > 0:
		anim.play("walk_right")
	elif direction.x < 0:
		anim.play("walk_left")
	elif direction.y > 0:
		anim.play("walk_down")
	elif direction.y < 0:
		anim.play("walk_up")
func _process(delta):

	if Input.is_action_just_pressed("interact"):
		check_interaction()

func check_interaction():

	if $RayCast2D.is_colliding():

		var target = $RayCast2D.get_collider()

		if target.has_method("interact"):
			target.interact()
