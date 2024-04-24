extends Node2D


func _on_start_button_up():
	Global.sound_btn()
	get_tree().change_scene("res://scenes/levels.tscn")


func _on_exit_button_up():
	Global.sound_btn()
	get_tree().quit()


func _on_about_button_up():
	Global.sound_btn()
	get_tree().change_scene("res://scenes/about.tscn")
