extends Camera2D

# Get 4 world boundaries to place at camera borders
@export var bottom_boundary: CollisionShape2D;
@export var top_boundary: CollisionShape2D;
@export var left_boundary: CollisionShape2D;
@export var right_boundary: CollisionShape2D;
@export var boundaries_disabled: bool;

func _physics_process(delta: float) -> void:
	# Get camera size and place boundaries at edges
	bottom_boundary.disabled = boundaries_disabled;
	top_boundary.disabled = boundaries_disabled;
	left_boundary.disabled = boundaries_disabled;
	right_boundary.disabled = boundaries_disabled;
	
	if !boundaries_disabled:
		var zoom_factor = zoom * 2
		var positions: Vector2 = get_viewport_rect().size;
		bottom_boundary.position = Vector2(0, positions.y) / zoom_factor;
		top_boundary.position = Vector2(0, -positions.y) / zoom_factor;
		left_boundary.position = Vector2(positions.x, 0) / zoom_factor;
		right_boundary.position = Vector2(-positions.x, 0) / zoom_factor;
