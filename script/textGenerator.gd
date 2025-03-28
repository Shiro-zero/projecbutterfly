extends Node

func generate_text(i : int):
	return(read("res://assets/text/info.json")[str(Global.day)][str(i)]["text"])

func generate_title(i : int):
	return(read("res://assets/text/info.json")[str(Global.day)][str(i)]["titre"])

func generate_stat(i : int):
	return(read("res://assets/text/info.json")[str(Global.day)][str(i)]["stat"])
	
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
