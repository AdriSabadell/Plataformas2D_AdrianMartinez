extends Area2D

func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.add_bullets()
		queue_free()
		
		
