extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_jugar_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _on_salir_pressed():
	get_tree().quit()
