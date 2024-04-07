extends Area2D

@export var Enemy_scene: Area2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




func _on_area_entered(area):
	if area.is_in_group("Bullet"):
		print("MuerteEnemyScene")
		if Enemy_scene != null:
			Enemy_scene.queue_free()
