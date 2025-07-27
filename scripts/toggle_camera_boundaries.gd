extends CheckButton

var camera: Camera2DWithBoundaries;

func _ready() -> void:
	camera = get_tree().root.get_child(0).get_node("Camera2D");
	
func _toggled(toggled_on: bool) -> void:
	camera.toggle();
