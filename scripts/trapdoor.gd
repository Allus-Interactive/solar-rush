extends StaticBody2D

@export var player: CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer

var is_open: bool = false

func _ready():
	player.connect("open_trapdoor", trigger_open_animation)

func trigger_open_animation():
	if not is_open:
		animation_player.play("open")
		is_open = true
		timer.start(3)

func _on_timer_timeout() -> void:
		animation_player.play_backwards("open")
		is_open = false
		timer.stop()
