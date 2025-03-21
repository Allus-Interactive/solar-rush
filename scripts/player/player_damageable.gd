extends Node

class_name PlayerDamageable

signal on_player_hit(node : Node, damage_taken : int, knockback_direction : Vector2)

@export var health : int = 20 : 
	get:
		return health
	set(value):
		# SignalBus.emit_signal("on_player_health_changed", get_parent(), value - health)
		health = value

func hit(damage : int, knockback_direction : Vector2):
	health -= damage
	
	emit_signal("on_player_hit", get_parent(), damage, knockback_direction)

func _on_animation_tree_animation_finished(anim_name):
	if (anim_name == "dead"):
		# enemy is dead, remove from scene
		get_parent().queue_free()
