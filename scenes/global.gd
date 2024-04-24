extends AudioStreamPlayer

var level = 0
var h_level = 0
var data_path = "user://data.json"

func sound_btn():
	stream = load("res://audio/select_003.ogg")
	play()
	
func _ready():
	
	var file = File.new()
	if file.file_exists(data_path):
		file.open(data_path, File.READ)
		var data = parse_json(file.get_as_text())
		file.close()
		if typeof(data) == TYPE_DICTIONARY:
			h_level = data["h_level"]
	else:
		update_data()

func update_data():
	var file = File.new()
	file.open(data_path, File.WRITE)
	file.store_string(to_json({
		"h_level":h_level,
		}))
	file.close()
