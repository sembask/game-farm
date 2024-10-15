extends CharacterBody2D

const SPEED = 120.0
var vetor: Vector2 = Vector2.ZERO
var parado = false
var ultima_direcao = ""
var anim_loop_temp: String = "" 
var colidiu_porta = false

func _ready() -> void:
	$AnimatedSprite2D.play("parado")
	#if Dados.personagem == null:
		#Dados.personagem = self  # Registra o personagem no singleton
	#else:
		#queue_free()  # Evita instanciar dois personagens

func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO
	
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")

	if direction != Vector2.ZERO:
		vetor = direction.normalized() * SPEED
		parado = false
		ultima_direcao = get_direcao(vetor)
		tocar_animacao(ultima_direcao)
	else:
		vetor = Vector2.ZERO
		parado = true
		tocar_animacao_parada()

	velocity = vetor
	move_and_slide()
	
	if colidiu_porta and Input.is_action_just_pressed("acao_geral"):
		Dados.personagem_position = position  # Salva a posição
		Dados.cena_atual = "res://principal.tscn"
		get_tree().change_scene_to_file("res://interior_casa.tscn")
		colidiu_porta = false

		
func get_direcao(v: Vector2) -> String:
	if abs(v.x) > abs(v.y):
		return "direita" if v.x > 0 else "esquerda"
	else:
		return "baixo" if v.y > 0 else "cima"

func tocar_animacao(direcao: String) -> void:
	match direcao:
		"esquerda":
			tocar_animacao_inicio_e_loop("andando_esquerda_inicio", "andando_esquerda_loop")
		"direita":
			tocar_animacao_inicio_e_loop("andando_direita_inicio", "andando_direita_loop")
		"cima":
			tocar_animacao_inicio_e_loop("andando_cima", "andando_cima_loop")
		"baixo":
			tocar_animacao_inicio_e_loop("andando_baixo", "andando_baixo_loop")

func tocar_animacao_inicio_e_loop(anim_inicio: String, anim_loop: String) -> void:
	if $AnimatedSprite2D.animation != anim_loop: 
		anim_loop_temp = anim_loop  
		$AnimatedSprite2D.play(anim_inicio)
		await $AnimatedSprite2D.animation_finished
		$AnimatedSprite2D.play(anim_loop_temp) 

func tocar_animacao_parada() -> void:
	match ultima_direcao:
		"esquerda":
			$AnimatedSprite2D.play("andando_esquerda_inicio")
			$AnimatedSprite2D.frame = 1
		"direita":
			$AnimatedSprite2D.play("andando_direita_inicio")
			$AnimatedSprite2D.frame = 1
		"cima":
			$AnimatedSprite2D.play("andando_cima")
			$AnimatedSprite2D.frame = 1
		"baixo":
			$AnimatedSprite2D.play("andando_baixo")
			$AnimatedSprite2D.frame = 1

func _on_sementes_body_entered(body: Node2D) -> void:
	Dados.semente += 1

func _on_porta_area_2d_body_entered(body: Node2D) -> void:
	colidiu_porta = true 
