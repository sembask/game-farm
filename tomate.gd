extends Area2D

var colidiu = false
var plantou = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	$"../borboleta/AnimationPlayer".play("voando")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$"../seguindo_informacoes/semente_tomate".text = str("semente de tomate = ",Dados.semente)
	
	if Dados.semente >= 1 and colidiu and jogar_semente() and !plantou:
		plantar_tomate()
		

func jogar_semente() -> bool:
	return Input.is_action_just_pressed("ui_accept")
	
	
func _on_body_entered(body: Node2D) -> void:
	colidiu = true
			
func _on_body_exited(body: Node2D) -> void:
	colidiu = false
	$"../borboleta/AnimationPlayer".play("noite")
	await get_tree().create_timer(15.0).timeout
	$"../borboleta/AnimationPlayer".play("dia")

func plantar_tomate() -> void:
	show()
	Dados.semente -= 1
	plantou = true
	
	$AnimatedSprite2D.frame = 0
	await get_tree().create_timer(3.0).timeout
	$AnimatedSprite2D.frame = 1
	await get_tree().create_timer(5.0).timeout
	$AnimatedSprite2D.frame = 2		
	await get_tree().create_timer(7.0).timeout
	$AnimatedSprite2D.frame = 3
	await get_tree().create_timer(7.0).timeout
	$AnimatedSprite2D.frame = 4
	await get_tree().create_timer(7.0).timeout
	$AnimatedSprite2D.frame = 5
	plantou = false
