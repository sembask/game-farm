extends Area2D

var plantou = false
var pode_colher = false
var colidiu_milho = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	show()
	Dados.semente -= 1
	plantou = true
	
	$AnimatedSprite2D.frame = 0
	await get_tree().create_timer(2.0).timeout
	$AnimatedSprite2D.frame = 1
	await get_tree().create_timer(3.0).timeout
	$AnimatedSprite2D.frame = 2		
	await get_tree().create_timer(4.0).timeout
	$AnimatedSprite2D.frame = 3
	await get_tree().create_timer(5.0).timeout
	$AnimatedSprite2D.frame = 4
	await get_tree().create_timer(6.0).timeout
	$AnimatedSprite2D.frame = 5
	plantou = false
	pode_colher = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if pode_colher and Input.is_action_just_pressed("colher") and colidiu_milho:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	colidiu_milho = true


func _on_body_exited(body: Node2D) -> void:
	colidiu_milho = false
