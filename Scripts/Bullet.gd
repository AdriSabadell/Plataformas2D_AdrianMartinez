extends Area2D

var velocidad = 450

func _ready():
	pass  

func _process(delta):
	position.x += velocidad * delta

func _on_area_entered(area):
	if area.is_in_group("Enemy"):
		print("Golpe")
		queue_free()

func _on_body_entered(body):
	if body.is_in_group("Terreno"):
		queue_free()
		

