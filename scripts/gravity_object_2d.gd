class_name GravityObject2D extends CharacterBody2D

const G: float = 6.6743e-11 
@export var camera: Camera2D;
# Two colliders prevents colliders sticking to each other
@export var collider1: CollisionShape2D;
@export var collider2: CollisionShape2D;
@export var starting_velocity: Vector2 = Vector2.ZERO;
@export_range(1, 1000, 1, "suffix:px") var radius: float = 100;
@export_range(1, 10e18, 10e15, "suffix:kg") var mass: float = 10e16;
# To text to draw with
@export var label: String;

# continually add to velocity to accelerate
func accelerate(direction: Vector2):
	velocity += direction;
	
func get_gravity_objects() -> Array[GravityObject2D]:
	var x: Array[GravityObject2D]
	for child in get_parent().get_children():
		if child is GravityObject2D:
			x.append(child)
	return x

func _ready() -> void:
	var collision_shape: CircleShape2D = CircleShape2D.new();
	collision_shape.radius = radius;
	# Resize collision shapes to match drawn circle radius
	collider1.shape = collision_shape;
	collider2.shape = collision_shape;
	accelerate(starting_velocity)

func _physics_process(delta: float) -> void:
	for object in get_gravity_objects():
		if object == self:
			continue
		var dx: float = object.position.x - self.position.x
		var dy: float = object.position.y - self.position.y
		var distance: float = sqrt(dx*dx+dy*dy)
		var direction: Vector2 = Vector2(dx / distance, dy / distance);
		
		var gforce: float = (G * self.mass * object.mass) / (distance * distance)
		var acc1 = gforce / self.mass
		var acceleration = Vector2(acc1 * direction.x, acc1 * direction.y)
		accelerate(acceleration)
		print(acc1)
	
	var collision_info = move_and_collide(velocity * delta);
	if collision_info:
		# Bounce back with 95% of original speed to simulate energy loss
		velocity = velocity.bounce(collision_info.get_normal())# * 0.95;

func _draw():
	# Draw a circle and text
	draw_circle(Vector2.ZERO, radius, Color.WHITE)
	draw_string(ThemeDB.fallback_font, Vector2(0, -100), label,
				HORIZONTAL_ALIGNMENT_CENTER, 130, 55)
