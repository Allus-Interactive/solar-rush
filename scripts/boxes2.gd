extends StaticBody2D

@export var player: CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	player.connect("break_object_2", on_break_object_2)

func on_break_object_2():
	animation_player.play("break")
