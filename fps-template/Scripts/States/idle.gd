extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	var animation : Animation = player.animation_player.get_animation("Idle")
	animation.loop_mode = Animation.LOOP_LINEAR
	player.animation_player.play("Idle")
	

func physics_update(delta: float) -> void:
	player.move_player(delta)

	if not player.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right") or Input.is_action_pressed("move_forward" )or Input.is_action_pressed("move_back"):
		finished.emit(RUNNING)
