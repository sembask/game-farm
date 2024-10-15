extends Area2D

var plantou = false
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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
