extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _process(delta: float):
	pass

func _on_timer_timeout():
		get_tree().change_scene_to_file("res://scenes/main.tscn")
