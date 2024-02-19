extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -400.0
const ACCELERATION = 10.0  

var lifes = 5

@onready var anim = $AnimatedSprite2D


@onready var heart1 : Sprite2D = get_node("CanvasLayer/Corazon")
@onready var heart2 : Sprite2D = get_node("CanvasLayer/Corazon2")
@onready var heart3 : Sprite2D = get_node("CanvasLayer/Corazon3")
@onready var heart4 : Sprite2D = get_node("CanvasLayer/Corazon4")
@onready var heart5 : Sprite2D = get_node("CanvasLayer/Corazon5")
@onready var score_text : Label = get_node("CanvasLayer/Balas")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var bullet_scene: PackedScene

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# Acciones.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		"jump()"
	if Input.is_action_just_pressed("Shoot"):
		shoot()
	if Input.is_action_just_pressed("Escape"):
		pausa()
	var input_strength = Input.get_action_strength("Move_Right") - Input.get_action_strength("Move_Left")
	velocity.x = lerp(velocity.x, input_strength * SPEED, ACCELERATION * delta)
	anim.play("Run")
	move_and_slide()
	
	if global_position.y > 200:
		game_over()
#Disparar
func shoot():
		var bullet = bullet_scene.instantiate()
		var marker_position = $AnimatedSprite2D/Marker2D.global_position
		bullet.position = marker_position
		get_parent().add_child(bullet)
		

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
		
		
"""func add_score(amount):
	Globals.Score += amount
	score_text.text = str("Score: ", Globals.Score)"""

func game_over():
	#get_tree().reload_current_scene()
	get_tree().call_deferred("reload_current_scene")
#Pausa
func pausa():
	#get_tree().paused = true
	$CanvasLayer/MenuPausa.visible = true
func _on_reanude_pressed():
	$CanvasLayer/MenuPausa.visible = false
	#get_tree().paused = false

func _on_exit_pressed():
		get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")

func _on_restart_pressed():
		get_tree().call_deferred("reload_current_scene")
