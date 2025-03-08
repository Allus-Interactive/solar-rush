extends CanvasLayer

# var main_scene = preload("res://scenes/main.tscn").instantiate()

func _physics_process(delta):
	if Input.is_action_just_pressed("interact"):
		get_tree().change_scene_to_file("res://scenes/main.tscn")
