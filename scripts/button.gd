extends Area2D

@export var player: CharacterBody2D
@export var button_id: int

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	player.connect("press_button", on_press_animation)

func on_press_animation():
		animation_player.play("press_button")
