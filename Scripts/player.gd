extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -400.0
const ACCELERATION = 10.0

var lifes = 5
#var velocidadBullet = 450

@onready var anim = $AnimatedSprite2D


@onready var heart1 : Sprite2D = get_node("CanvasLayer/Corazon")
@onready var heart2 : Sprite2D = get_node("CanvasLayer/Corazon2")
@onready var heart3 : Sprite2D = get_node("CanvasLayer/Corazon3")
@onready var heart4 : Sprite2D = get_node("CanvasLayer/Corazon4")
@onready var heart5 : Sprite2D = get_node("CanvasLayer/Corazon5")
@onready var score_text : Label = get_node("CanvasLayer/Balas")

var num_bullets = 0


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var bullet_scene: PackedScene

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		$SonidoAndar.playing = false

	# Acciones.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("Shoot") and num_bullets > 0:
		shoot()
		
	if Input.is_action_just_pressed("Escape"):
		pausa()

	var input_strength = Input.get_action_strength("Move_Right") - Input.get_action_strength("Move_Left")
	velocity.x = lerp(velocity.x, input_strength * SPEED, ACCELERATION * delta)
	move_and_slide()
	#print(input_strength)
	if is_on_floor():
		if input_strength == 0:
			#print("Quieto")
			anim.play("Idle")
		if input_strength == -1:
			#print("Izquierda")
			anim.play("Run")
			anim.scale.x = -1
		if input_strength == 1:
			#print("Derecha")
			anim.play("Run")
			anim.scale.x = 1
	if not is_on_floor():
		anim.play("Jump")
		
	if global_position.y > 200:
		game_over()
#Disparar
func shoot():
	var bullet = bullet_scene.instantiate()
	var marker_position = $AnimatedSprite2D/Marker2D.global_position
	bullet.position = marker_position
	get_parent().add_child(bullet)
	$SonidoDisparo.playing = true
	# Disminuir el número de balas
	num_bullets -= 1
	score_text.text = str(num_bullets)
	if anim.scale.x == 1 :
		bullet.velocidad = 450
	if anim.scale.x == -1:
		bullet.velocidad =-450
		

#Vidas
func loseLife(enemyposx):
	if position.x < enemyposx:
		velocity.x = -500
		velocity.y = -300
	
	if position.x > enemyposx:
		velocity.x = 500
		velocity.y = -300
	lifes = lifes-1
	"""print("Vida actual: " +str(lifes))"""
	if lifes <= 0:
		heart1.visible = false
		game_over()
	if lifes == 1:
		heart2.visible = false
	if lifes == 2:
		heart3.visible = false
	if lifes == 3:
		heart4.visible = false
	if lifes == 4:
		heart5.visible = false
	
	$SonidoGolpe.playing = true

#Recargar
func add_bullets():
	num_bullets = 5
	score_text.text = str(num_bullets)
	print("Recarga")

func add_life():
	lifes = 5
	heart5.visible = true
	heart4.visible = true
	heart3.visible = true
	heart2.visible = true
func game_over():
	get_tree().call_deferred("reload_current_scene")
#Pausa
func pausa():
	$CanvasLayer/MenuPausa.visible = true
func _on_reanude_pressed():
	$CanvasLayer/MenuPausa.visible = false

func _on_exit_pressed():
		get_tree().change_scene_to_file("res://Scenes/Levels/MainMenu.tscn")

func _on_restart_pressed():
		get_tree().call_deferred("reload_current_scene")
