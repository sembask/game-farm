extends CharacterBody2D

const SPEED = 120.0
const JUMP_VELOCITY = -400.0
var vetor: Vector2 = Vector2(0,0)
var parado = false
var ultima_direcao = ""
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		pass
		#velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionx := Input.get_axis("ui_left", "ui_right")
	if directionx:
		vetor.x = directionx
		parado = false
	else:
		vetor.x = 0
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		xy_parados()
		
	var directiony := Input.get_axis("ui_up", "ui_down")
	if directiony:
		vetor.y = directiony
		parado = false
	else:
		vetor.y = 0
		xy_parados()
		#velocity.y = move_toward(velocity.y, 0, SPEED)
		
	velocity = vetor.normalized() * SPEED
	move_and_slide()
	
	if Input.is_action_just_pressed("ui_left") and !parado:
		ultima_direcao = "esquerda"
		$AnimatedSprite2D.play("andando_esquerda")
		await $AnimatedSprite2D.animation_finished
		
		$AnimatedSprite2D.play("andanda_esquerda_loop")
	
	if Input.is_action_just_pressed("ui_right") and !parado:
		ultima_direcao = "direita"
		$AnimatedSprite2D.play("andando_direita_inicio")
		await $AnimatedSprite2D.animation_finished
	
		$AnimatedSprite2D.play("andando_direita_loop")
		
	if Input.is_action_just_pressed("ui_down") and !parado:
		ultima_direcao = "baixo"
		$AnimatedSprite2D.play("andando_baixo")
		await $AnimatedSprite2D.animation_finished
	
		$AnimatedSprite2D.play("andando_baixo_loop")
		
	if Input.is_action_just_pressed("ui_up") and !parado:
		ultima_direcao = "cima"
		$AnimatedSprite2D.play("andando_cima")
		await $AnimatedSprite2D.animation_finished
	
		$AnimatedSprite2D.play("andando_cima_loop")
		
	if parado:
		match ultima_direcao:
			"esquerda":
				$AnimatedSprite2D.play("andando_esquerda_inicio")
				$AnimatedSprite2D.frame = 1
			"direita":
				$AnimatedSprite2D.play("andando_direita_inicio")
				$AnimatedSprite2D.frame = 1
			"baixo":
				$AnimatedSprite2D.play("andando_baixo")
				$AnimatedSprite2D.frame = 1
			"cima":
				$AnimatedSprite2D.play("andando_cima")
				$AnimatedSprite2D.frame = 1

func xy_parados() -> void:
	if vetor.y == 0 and vetor.x == 0:
		parado = true
				
func _on_sementes_body_entered(body: Node2D) -> void:
	Dados.semente += 1
