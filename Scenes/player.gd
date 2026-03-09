extends CharacterBody2D

var speed = 500.0
var dir
var gravity = 980
var jump_velocity = -600
var extra_jumps = 1


func _ready() -> void:
	pass

func _physics_process (delta: float) -> void:
	move(delta)
	pass
	
func move(delta):
	dir = Input.get_axis("Left", "Right")
	
	if dir:
		velocity.x = dir * speed
	elif dir == 0:
		velocity.x = 0
		
	if not is_on_floor():
		velocity.y += gravity * delta
	
	
	if Input.is_action_just_pressed("Jump") and extra_jumps>0:
		velocity.y = jump_velocity
		if extra_jumps >= 0:
			extra_jumps -= 1
	
	if is_on_floor():
		extra_jumps = 1
	
	
	move_and_slide()
	pass
