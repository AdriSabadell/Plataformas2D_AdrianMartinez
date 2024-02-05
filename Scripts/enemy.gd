extends Area2D

# Propiedades
var speed = 75 
var start_position : Vector2
var end_position : Vector2
var moving_right = true
var lifes = 3
@export var final_position = 700
@onready var anim = $AnimatedSprite2D

func _ready():
	start_position = position
	end_position = Vector2(final_position, position.y) 
	anim.play("Walk")

func _process(delta):
	move_enemy(delta)

func move_enemy(delta):
	var velocity = Vector2()
	
	if moving_right:
		velocity.x = speed
	else:
		velocity.x = -speed
		

	
	translate(velocity * delta)

	# Verificar si alcanzó el punto final o inicial
	if moving_right and position.x > end_position.x:
		moving_right = false
		$AnimatedSprite2D.scale.x = -1  # Invertir horizontalmente
	elif not moving_right and position.x < start_position.x:
		moving_right = true
		$AnimatedSprite2D.scale.x = 1  # Restablecer la escala horizontal
	
func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.loseLife(position.x)
		print("Golpear")

func _on_area_entered(area):
	if area.is_in_group("Bullet"):
		print("Muerte")
		lifes = lifes-1
		if lifes <= 0:
			queue_free()
