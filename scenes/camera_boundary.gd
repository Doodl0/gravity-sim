extends Camera2D

# Get 4 world boundaries to place at camera borders
@export var bottom_boundary: CollisionShape2D;
@export var top_boundary: CollisionShape2D;
@export var left_boundary: CollisionShape2D;
@export var right_boundary: CollisionShape2D;

func _physics_process(delta: float) -> void:
	# Get camera size and place boundaries at edges
	var positions: Vector2 = get_viewport_rect().size;
	bottom_boundary.position = Vector2(0, positions.y);
	top_boundary.position = Vector2(0, -positions.y);
	left_boundary.position = Vector2(positions.x, 0);
	right_boundary.position = Vector2(-positions.x, 0);
