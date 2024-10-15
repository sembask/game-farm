extends Node2D
var colidiu_tapete = false

func _ready() -> void:
	$dialogo_cama.hide()
	var personagem = preload("res://fazendeiro.tscn").instantiate()
	#personagem.position = Vector2(100, 100)  # Posição inicial dentro da casa
	personagem.position = $tapete_instancia/CollisionShape2D.position

	add_child(personagem)
	$tapete_instancia.connect("body_entered", Callable(self, "_on_tapete_body_entered"))
	$tapete_instancia.connect("body_exited", Callable(self, "_on_tapete_body_exited"))
	$cama_static/cama_area2d.connect("body_entered", Callable(self, "_on_cama_body_entered"))
	$cama_static/cama_area2d.connect("body_exited", Callable(self, "_on_cama_body_exited"))

func _on_cama_body_entered(body: Node2D) -> void:
	if body.name == "fazendeiro":
		$dialogo_cama.text = str("a cama esta muito suja para deitar")
		$dialogo_cama.show()
		$dialogo_cama/AnimationPlayer.play("texto_da_cama")

func _on_cama_body_exited(body: Node2D) -> void:
	if body.name == "fazendeiro":
		$dialogo_cama.hide()
		
func _on_tapete_body_entered(body: Node2D) -> void:
	if body.name == "fazendeiro":
		colidiu_tapete = true

func _on_tapete_body_exited(body: Node2D) -> void:
	if body.name == "fazendeiro":
		colidiu_tapete = false  # Marca que o personagem saiu do tapete
		
func entrar_porta(colidiu_tapete) -> void:
	if colidiu_tapete and Input.is_action_just_pressed("acao_geral"):  # Verifica se o fazendeiro entrou no tapete
		Dados.personagem_position = Vector2(200, 300)  # Define a posição de retorno
		get_tree().change_scene_to_file(Dados.cena_atual)  # Volta para a cena principal
		

func _physics_process(delta: float) -> void:
	entrar_porta(colidiu_tapete)
