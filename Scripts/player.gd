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

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var bullet_scene: PackedScene

"""
var jump_height : float
var jump_time_to_peak : float
var jump_time_to_descend : float

@onready var jump_velocity : float = ((2.0 * jump_height)/ jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height)/ (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height)/ (jump_time_to_peak * jump_time_to_descend)) * -1.0
"""
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		"velocity.y += get_gravity() * delta"

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
	
"""
func get_gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity

"""

#Disparar
func shoot():
		var bullet = bullet_scene.instantiate()
		bullet.position = global_position
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


func game_over():
	#get_tree().reload_current_scene()
	get_tree().call_deferred("reload_current_scene")
"""
func jump():
	velocity.y = jump_velocity
"""

#Pausa
func pausa():
	#get_tree().paused = true
	$CanvasLayer/MenuPausa.visible = true
func _on_reanude_pressed():
	$CanvasLayer/MenuPausa.visible = false
	#get_tree().paused = false
func _on_exit_pressed():
		get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
