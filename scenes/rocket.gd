extends RigidBody2D

var p_r = false
var p_l = false
var u_r = false
var u_l = false
var power = 10
var torque = 50
var torque_u = 50
var fire = false

func _process(delta):
	if p_l or p_r or u_l or u_r:
		fire = true
	else:
		fire = false
	
	if p_r or p_l:
		var rotation_v = rotation + PI / -2
		var direction = Vector2(cos(rotation_v), sin(rotation_v))
		apply_central_impulse(direction*3)
		
	if u_r or u_l:
		var rotation_v = rotation + PI / 2
		var direction = Vector2(cos(rotation_v), sin(rotation_v))
		apply_central_impulse(direction*3)
	
	if p_r:
		apply_torque_impulse(-torque)
	if p_l:
		apply_torque_impulse(torque)
	if u_r:
		apply_torque_impulse(torque_u)
	if u_l:
		apply_torque_impulse(-torque_u)

func _input(event):
	if Input.is_action_just_pressed("ui_right"):
		p_r = true
		$fires/right/AnimationPlayer.play("burn")
	elif Input.is_action_just_released("ui_right"):
		p_r = false
		$fires/right/AnimationPlayer.play("stop")
		
	if Input.is_action_just_pressed("ui_left"):
		p_l = true
		$fires/left/AnimationPlayer.play("burn")
	elif Input.is_action_just_released("ui_left"):
		p_l = false
		$fires/left/AnimationPlayer.play("stop")
		
	if Input.is_action_just_pressed("u_r"):
		u_r = true
		$fires/u_r/AnimationPlayer.play("burn")
	elif Input.is_action_just_released("u_r"):
		u_r = false
		$fires/u_r/AnimationPlayer.play("stop")
		
	if Input.is_action_just_pressed("u_l"):
		u_l = true
		$fires/u_l/AnimationPlayer.play("burn")
	elif Input.is_action_just_released("u_l"):
		u_l = false
		$fires/u_l/AnimationPlayer.play("stop")
		

func _on_rocket_body_entered(body):
	if body.is_in_group("meteor"):
		get_parent().game_over()


func _on_down_left_pressed():
	p_l = true
	$fires/left/AnimationPlayer.play("burn")


func _on_down_left_released():
	p_l = false
	$fires/left/AnimationPlayer.play("stop")


func _on_up_left_pressed():
	u_l = true
	$fires/u_l/AnimationPlayer.play("burn")


func _on_up_left_released():
	u_l = false
	$fires/u_l/AnimationPlayer.play("stop")


func _on_down_right_pressed():
	p_r = true
	$fires/right/AnimationPlayer.play("burn")


func _on_down_right_released():
	p_r = false
	$fires/right/AnimationPlayer.play("stop")


func _on_up_right_pressed():
	u_r = true
	$fires/u_r/AnimationPlayer.play("burn")


func _on_up_right_released():
	u_r = false
	$fires/u_r/AnimationPlayer.play("stop")


func _on_Timer_timeout():
	if fire:
		if $fire.volume_db < 0:
			$fire.volume_db += 20
	else:
		if $fire.volume_db > -80:
			$fire.volume_db -= 3
