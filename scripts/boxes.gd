extends StaticBody2D

@export var player: CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	player.connect("break_object", on_break_object)

func on_break_object():
	animation_player.play("break")
