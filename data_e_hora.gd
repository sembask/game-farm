extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var tempo = Time.get_datetime_dict_from_system()
	
	text = str("%02d"%tempo.hour,":", "%02d"%tempo.minute,".","%02d"%tempo.second)
