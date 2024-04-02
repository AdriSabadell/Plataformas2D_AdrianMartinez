extends Area2D

var velocity = -450

func _process(delta):
	global_position.x += velocity * delta

func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.loseLife(position.x)
		print("Golpe")
		queue_free()
	
	


func _on_body_entered_terrain(body):
	if body.is_in_group("Terreno"):
		queue_free()
