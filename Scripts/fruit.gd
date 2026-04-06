extends StaticBody2D


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("Player"):
		Global.score += 1
		$AnimatedSprite2D.play("Collect")
		$Area2D/CollisionShape2D.queue_free()		
		await get_tree().create_timer(1).timeout
		queue_free()


func _on_flag_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("Player"):
		Global.score += 1
		$AnimatedSprite2D.play("Collect")
		$Area2D/CollisionShape2D.queue_free()		
		await get_tree().create_timer(1).timeout
		queue_free()

	pass # Replace with function body.
