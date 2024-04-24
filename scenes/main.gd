extends Node2D

var res_anim 
var win = true
var has_win = false

func _ready():
	$AdMob.load_banner()
	$AdMob.show_banner()
	
	var level = load("res://scenes/levels/resources_%s.tscn" % Global.level).instance()
	$level.add_child(level)
	res_anim = level.get_node("finish_area/AnimationPlayer")
	
	level.get_node("finish_area").connect("body_entered", self, "_on_finish_area_body_entered")
	level.get_node("finish_area").connect("body_exited", self, "_on_finish_area_body_exited")

func _process(delta):
	$on_screen_control.global_position.y = $rocket/Camera2D.get_camera_screen_center().y - 320
	$wall.global_position.y = $rocket.global_position.y
	$completed_form.global_position.y = $rocket.global_position.y - 320
	$win_form.global_position.y = $rocket.global_position.y
	$fail_form.global_position.y = $rocket.global_position.y

func _on_safe_area_body_exited(body):
	if body.is_in_group("rocket"):
		game_over()
		
func turn_off_rocket_coll():
	$rocket/CollisionShape2D.disabled = true
	$rocket/CollisionShape2D2.disabled = true
	$rocket/CollisionShape2D3.disabled = true

func game_over():
	if !has_win:
		$explode.play()
		call_deferred("turn_off_rocket_coll")
		$CanvasModulate/AnimationPlayer.play("game_over")
		yield($CanvasModulate/AnimationPlayer, "animation_finished")
		$fail_form/AnimationPlayer.play("show")

func _on_wall_body_entered(body):
	if body.is_in_group("rocket"):
		$alarm.play()
		$CanvasModulate/AnimationPlayer.play("warning")

func _on_wall_body_exited(body):
	if body.is_in_group("rocket"):
		$alarm.stop()
		$CanvasModulate/AnimationPlayer.stop()
		$CanvasModulate/AnimationPlayer.play("RESET")

func _on_finish_area_body_entered(body):
	if body.is_in_group("rocket"):
		res_anim.play("on_counting")
		$counting.play("counting")
		yield(res_anim, "animation_finished")
		if win:
			$win.play()
			
			if Global.level < 9:
				Global.level+=1
				
				
				$win_form/planet.texture = load("res://images/planets/%s.png" % Global.level)
				has_win = true
				call_deferred("turn_off_rocket_coll")
				$CanvasModulate.hide()
				$win_form/AnimationPlayer.play("show")
				if Global.h_level < Global.level:
					Global.h_level = Global.level
					
				Global.update_data()
				
			else:
				$completed_form/AnimationPlayer.play("show")
			
		win = true

func _on_finish_area_body_exited(body):
	if body.is_in_group("rocket"):
		win = false
		$counting.stop()
		res_anim.stop()
		res_anim.play("RESET")

func _on_ok_button_up():
	Global.sound_btn()
	get_tree().change_scene("res://scenes/main.tscn")


func _on_retry_button_up():
	Global.sound_btn()
	get_tree().change_scene("res://scenes/main.tscn")



func _on_exit_button_up():
	Global.sound_btn()
	get_tree().change_scene("res://scenes/levels.tscn")
