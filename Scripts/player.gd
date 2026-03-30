extends CharacterBody2D

var speed = 200.0
var dir
var gravity = 980
var jump_velocity = -400
var extra_jumps = 1
@onready var anim = $AnimatedSprite2D

var is_alive = true


func _ready() -> void:
	pass

func _physics_process (delta: float) -> void:
	move(delta)
	if is_alive:
		animations()
	pass
	
func move(delta):
	if is_alive:
		dir = Input.get_axis("Left", "Right")
	
	if dir:
		velocity.x = dir * speed
	elif dir == 0:
		velocity.x = 0
		
	if not is_on_floor():
		velocity.y += gravity * delta
	
	
	if Input.is_action_just_pressed("Jump") and extra_jumps>0 and is_alive:
		velocity.y = jump_velocity
		if extra_jumps >= 0:
			extra_jumps -= 1
	
	if is_on_floor():
		extra_jumps = 1
	
	
	move_and_slide()
	pass

func animations():
	if velocity.x != 0 and is_on_floor():
		anim.play("Run")
	elif velocity.x == 0 and is_on_floor():
		anim.play("Idle")
		
	if not is_on_floor() and extra_jumps >= 1:
		anim.play("Jump")
	
	if dir > 0:
		anim.flip_h = false
	elif dir < 0:
		anim.flip_h = true

func die():
	is_alive = false
	anim.play("Hit")
	
	$CollisionShape2D.queue_free()
	$Area2D/CollisionShape2D.queue_free()
	velocity.y = jump_velocity - 100
	velocity.x = jump_velocity + 1000000
	camera_zoom()
	await get_tree().create_timer(1.2).timeout
	get_tree().reload_current_scene()

func camera_zoom():
	var zoom = 2.0
	var new_zoom = 4.0
	
	$Camera2D.zoom = Vector2(new_zoom, new_zoom)
	Engine.time_scale = 0.5
	await get_tree().create_timer(1).timeout
	
	$Camera2D.zoom = Vector2(zoom, zoom)
	Engine.time_scale = 1.0
