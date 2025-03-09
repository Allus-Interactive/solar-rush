extends Area2D

@export var damage : int = 10
@export var player : Player
@export var facing_shape : FacingCollisionShape2D

signal hit_breakable
signal hit_breakable_2
signal hit_breakable_3
signal hit_breakable_4
signal hit_breakable_5

func _ready():
	monitoring = false
	player.connect("facing_direction_changed", _on_player_facing_direction_changed)

func _on_body_entered(body):
	print(body.name)
	if body.name == "Boxes":
		emit_signal("hit_breakable")
	elif body.name == "Boxes2":
		emit_signal("hit_breakable_2")
	elif body.name == "Boxes3":
		emit_signal("hit_breakable_3")
	elif body.name == "Boxes4":
		emit_signal("hit_breakable_4")
	elif body.name == "Boxes5":
		emit_signal("hit_breakable_5")

func _on_player_facing_direction_changed(facing_right : bool):
	if facing_right:
		facing_shape.position = facing_shape.facing_right_postion
	else:		
		facing_shape.position = facing_shape.facing_left_postion
