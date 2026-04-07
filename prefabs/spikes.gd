extends StaticBody2D

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	pass

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("Player"):
		area.get_parent().die()
		print("Hit")
	pass # Replace with function body.
