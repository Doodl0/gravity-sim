extends Node

@export var quit_on_escape: bool;

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			if quit_on_escape:
				get_tree().quit();
			else:
				get_tree().change_scene_to_file("res://scenes/UI/main_menu.tscn");
