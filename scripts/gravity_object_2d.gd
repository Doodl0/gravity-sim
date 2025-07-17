extends CharacterBody2D

@export var camera: Camera2D;
# Two colliders prevents colliders sticking to each other
@export var collider1: CollisionShape2D;
@export var collider2: CollisionShape2D;
@export var starting_velocity: Vector2 = Vector2.ZERO;
@export var radius: float = 10;
# To text to draw with
@export var label: String;

# continually add to velocity to accelerate
func accelerate(direction: Vector2):
	velocity += direction;

func _ready() -> void:
	var collision_shape: CircleShape2D = CircleShape2D.new();
	collision_shape.radius = radius;
	# Resize collision shapes to match drawn circle radius
	collider1.shape = collision_shape;
	collider2.shape = collision_shape;

func _physics_process(delta: float) -> void:
	accelerate(starting_velocity);
	var collision_info = move_and_collide(velocity * delta);
	if collision_info:
		# Bounce back with 95% of original speed to simulate energy loss
		velocity = velocity.bounce(collision_info.get_normal()) * 0.95;

func _draw():
	# Draw a circle and text
	draw_circle(Vector2.ZERO, radius, Color.WHITE)
	draw_string(ThemeDB.fallback_font, Vector2(0, -100), label,
				HORIZONTAL_ALIGNMENT_CENTER, 130, 55)
