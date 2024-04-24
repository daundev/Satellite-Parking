extends Node2D


func _on_exit_button_up():
	Global.sound_btn()
	get_tree().change_scene("res://scenes/front.tscn")
