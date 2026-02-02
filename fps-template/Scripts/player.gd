class_name Player extends CharacterBody3D

@export var player_res: PlayerRes

@onready var neck: Node3D = $Neck
@onready var camera: Camera3D = $Neck/Camera3D
@onready var player_mesh: Node3D = $CharacterModelV4

var is_paused = false
var mesh

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	mesh = ImmediateMesh.new()
	# Optional: Set a material for unshaded/colored lines
	var material = StandardMaterial3D.new()
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.GREEN


func move_player(delta: float) -> void:
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")

	var direction := (neck.global_transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction != Vector3.ZERO:
		velocity.x = direction.x * player_res.move_speed
		velocity.z = direction.z * player_res.move_speed
		rotate_player_from_direction(-direction, delta)
	else:
		velocity.x = move_toward(velocity.x, 0.0, player_res.move_speed)
		velocity.z = move_toward(velocity.z, 0.0, player_res.move_speed)

	move_and_slide()


func fall_player(delta: float):
	velocity.y += player_res.gravity * delta
	move_and_slide()


func rotate_player_from_direction(direction: Vector3, delta: float) -> void:
	if direction == Vector3.ZERO:
		return

	# Only rotate on Y (XZ plane)
	var flat_dir = direction
	flat_dir.y = 0
	if flat_dir == Vector3.ZERO:
		return

	flat_dir = flat_dir.normalized()

	var target_y := atan2(flat_dir.x, flat_dir.z)
	player_mesh.rotation.y = lerp_angle(player_mesh.rotation.y, target_y, 10.0 * delta)
