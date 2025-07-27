class_name GravityObject3D extends CharacterBody3D

const G: float = 0.1
# Two colliders prevents colliders sticking to each other
@export var mesh: MeshInstance3D;
@export var collider: CollisionShape3D;
@export var starting_velocity: Vector3 = Vector3.ZERO;
@export var radius: float = 1;
@export var mass: float = 100;

# continually add to velocity to accelerate
func accelerate(direction: Vector3):
	velocity += direction;
	
func get_gravity_objects() -> Array[GravityObject3D]:
	var x: Array[GravityObject3D]
	for child in get_parent().get_children():
		if child is GravityObject3D:
			x.append(child)
	return x

func _ready() -> void:
	# Resize collision shapes to match radius
	var collision_shape: SphereShape3D = SphereShape3D.new();
	collision_shape.radius = radius;
	collider.shape = collision_shape;
	
	#Resize collision shapes to match radius
	var mesh_shape: SphereMesh = SphereMesh.new();
	mesh_shape.radius = radius;
	mesh_shape.height = radius * 2;
	mesh.mesh = mesh_shape;
	
	accelerate(starting_velocity)

func _physics_process(delta: float) -> void:
	for object in get_gravity_objects():
		if object == self:
			continue
		var dx: float = object.position.x - self.position.x
		var dy: float = object.position.y - self.position.y
		var dz: float = object.position.z - self.position.z
		var distance: float = sqrt(dx*dx+dy*dy+dz*dz)
		var direction: Vector3 = Vector3(dx / distance, dy / distance, dz / distance);
		
		var gforce: float = (G * self.mass * object.mass) / (distance * distance)
		var acc1 = gforce / self.mass
		var acceleration = Vector3(acc1 * direction.x, acc1 * direction.y, acc1 * direction.z)
		accelerate(acceleration)
	
	var collision_info = move_and_collide(velocity * delta);
	if collision_info:
		# Bounce back with 95% of original speed to simulate energy loss
		velocity = velocity.bounce(collision_info.get_normal())# * 0.95;
