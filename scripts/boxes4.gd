extends StaticBody2D

@export var player: CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	player.connect("break_object_4", on_break_object_4)

func on_break_object_4():
	animation_player.play("break")
