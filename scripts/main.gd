extends Node2D

@onready var timer : Timer = $CountdownTimer
@onready var timer_label: Label = $CanvasLayer/TimerLabel

func _process(_delta):
	timer_label.text = "Time Until Solar Flare Hits: " + "%d:%02d" % [floor(timer.time_left / 60), int(timer.time_left) % 60]

func _on_countdown_timer_timeout():
	get_tree().change_scene_to_file("res://scenes/menus/game_over.tscn")
