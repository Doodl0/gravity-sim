extends MenuButton

@export var scene_path: String;

func _pressed() -> void:
	get_tree().change_scene_to_file(scene_path);
