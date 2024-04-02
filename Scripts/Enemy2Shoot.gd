extends Area2D


var velocidad_disparo = 1.0
var tiempo_entre_disparos = 1.0
var tiempo_ultimo_disparo = 0.0
var bala = preload("res://Scenes/BulletEnemy.tscn")

@onready var area_vision = $"Area de vision" 

var jugador_en_area_vision = false

func _on_body_entered(body):
	if body.is_in_group("Player"): 
		jugador_en_area_vision = true
		start_shooting()
		print("EntraJugador")
		

func _on_body_exited(body):
	if body.is_in_group("Player"): 
		jugador_en_area_vision = false
		print("JugadorSale")


func start_shooting():
	if jugador_en_area_vision:
		set_process(true)
		print("Llamada")


func _process(delta):
	if jugador_en_area_vision and tiempo_ultimo_disparo >= tiempo_entre_disparos:
		shoot()
		tiempo_ultimo_disparo = 0.0
	else:
		tiempo_ultimo_disparo += delta


func shoot():
	var nueva_bala = bala.instantiate()
	var marker_position = $Marker2D.global_position
	nueva_bala.position = marker_position
	$SonidoDisparo.playing = true
	get_parent().add_child(nueva_bala) 
	print("Disparo Enemigo")



