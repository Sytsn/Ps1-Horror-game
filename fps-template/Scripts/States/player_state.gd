class_name PlayerState extends State

const IDLE = "Idle"
const RUNNING = "Running"
const FALLING = "Falling"

var player: Player


func _ready() -> void:
	await owner.ready
	player = owner as Player
	assert(player != null, "The PlayerState state type must be used only in the player scene. It needs the owner to be a Player node.")


func update(_delta: float) -> void:
	if Input.is_action_just_released("ui_cancel") and not player.is_paused:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		player.is_paused = true
	elif Input.is_action_just_released("ui_cancel") and player.is_paused:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		player.is_paused = false


func handle_input(_event: InputEvent) -> void:
	if _event is InputEventMouseMotion:
		player.neck.rotate_y(-_event.relative.x * player.player_res.mouse_sens)
