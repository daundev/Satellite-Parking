extends Node2D

func _ready():
	for planet_btn_idx in len($Background/ScrollContainer/Control/planets.get_children()):
		var planet_btn = $Background/ScrollContainer/Control/planets.get_child(planet_btn_idx)
		var btn = planet_btn.get_child(2)
		if planet_btn_idx-1 < Global.h_level:
			btn.connect("button_up", self, "planet_btn_sign", [planet_btn_idx])
		else:
			btn.disabled = true
			btn.mouse_default_cursor_shape = Control.CURSOR_ARROW
			planet_btn.modulate = Color(1,1,1,.5)
		
func planet_btn_sign(planet_btn_idx):
	Global.level = planet_btn_idx
	print(planet_btn_idx)
	get_tree().change_scene("res://scenes/main.tscn")


func _on_TextureButton_button_up():
	Global.sound_btn()
	get_tree().change_scene("res://scenes/front.tscn")
