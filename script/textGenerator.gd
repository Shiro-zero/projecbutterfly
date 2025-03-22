extends Node

func generate_text():
	
	return(read("res://assets/text/tbody.json")[str(randi() % 3)][str(randi() % 3)])

func generate_title():
	return(read("res://assets/text/titre.json")[str(randi() % 3)][str(randi() % 3)])

func read(file_path):
	# Check if the file exists
	if FileAccess.file_exists(file_path):
		# Open the file for reading
		var file = FileAccess.open(file_path, FileAccess.READ)
		if file:
			# Read the file content
			var json_data = file.get_as_text()
			file.close()

			# Create an instance of JSON
			var json_object = JSON.parse_string(json_data)

			
			return json_object
	else:
		print("File does not exist.")
		return "File does not exist."
