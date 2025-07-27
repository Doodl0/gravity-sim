extends TextureButton
	
func _toggled(toggled_on: bool) -> void:
	if toggled_on:
		get_tree().paused = true
		print("stopped")
	else:
		get_tree().paused = false
		print("started")
