extends Node2D
var node_milho = preload("res://milho.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_released("ui_accept"):
		var instance_node_milho = node_milho.instantiate()
		instance_node_milho.position = $fazendeiro.position
		add_child(instance_node_milho)
