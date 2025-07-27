extends VBoxContainer

@export var mass_edit: SpinBox;
@export var radius_edit: SpinBox;
@export var velocity_x_edit: SpinBox;
@export var velocity_y_edit: SpinBox;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mass_edit.get_line_edit().context_menu_enabled = false;
	radius_edit.get_line_edit().context_menu_enabled = false;

func _input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_RIGHT:		
		var gravity_object = preload("res://scenes/2D/gravity_object_2d.tscn").instantiate()
		gravity_object.mass = float(mass_edit.value);
		gravity_object.radius = int(radius_edit.value);
		gravity_object.starting_velocity = Vector2(velocity_x_edit.value, velocity_y_edit.value)
		gravity_object.position = screen_to_world(event.position);
		get_tree().root.get_child(0).get_node("GravityObjects").add_child(gravity_object);

func screen_to_world(screen_coords: Vector2) -> Vector2:
	var camera: Camera2D = get_viewport().get_camera_2d();
	# center coordinates by subtracing half the screensize, then add camera position (assuming no camera offset)
	var translation: Vector2 = get_viewport_rect().size / 2 - camera.position;
	# translate coords and adjust for camera zoom by dividing
	var pos: Vector2 = (screen_coords - translation) / camera.zoom;
	return pos;
