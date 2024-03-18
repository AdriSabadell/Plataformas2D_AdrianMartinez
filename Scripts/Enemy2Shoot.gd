extends Area2D

# Variables para el enemigo
var velocidad_disparo = 1.0
var tiempo_entre_disparos = 1.0
var tiempo_ultimo_disparo = 0.0
var bala = preload("res://Scenes/BulletEnemy.tscn")

@onready var area_vision = $"Area de vision" # Asigna la referencia al área de visión en el editor

# Variable para rastrear si el jugador está dentro del área de visión
var jugador_en_area_vision = false

func _on_body_entered(body):
	if body.is_in_group("Player"): # Verifica si el cuerpo es el jugador
		jugador_en_area_vision = true
		start_shooting()
		print("EntraJugador")
		

func _on_body_exited(body):
	if body.is_in_group("Player"): # Verifica si el cuerpo es el jugador
		jugador_en_area_vision = false
		print("JugadorSale")

# Función para iniciar el disparo si el jugador está en el área de visión
func start_shooting():
	if jugador_en_area_vision:
		set_process(true)
		print("Llamada")

# Función que se llama en cada frame
func _process(delta):
	if jugador_en_area_vision and tiempo_ultimo_disparo >= tiempo_entre_disparos:
		shoot()
		tiempo_ultimo_disparo = 0.0
	else:
		tiempo_ultimo_disparo += delta

# Función para realizar el disparo
func shoot():
	var nueva_bala = bala.instantiate()
	var marker_position = $Marker2D.global_position
	nueva_bala.position = marker_position
	#nueva_bala.global_position = global_position # Posición de la bala igual a la del enemigo
	get_parent().add_child(nueva_bala) # Añade la bala como hijo del nodo padre del enemigo
	print("Disparo Enemigo")



