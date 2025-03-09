extends CharacterBody2D

class_name Player

@export var speed : float = 200.0
@export var hit_state : State

@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine
@onready var fallen_timer: Timer = $FallenTimer
@onready var end_game_timer: Timer = $EndGameTimer
@onready var game_over_timer: Timer = $GameOverTimer
#@onready var sword: Area2D = $Sword

var is_over_button : bool = false

signal open_trapdoor
signal press_button
signal break_object
signal break_object_2
signal break_object_3
signal break_object_4
signal break_object_5

# Get the gravity from the project settings to be synced with RigidBody nodes
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : Vector2 = Vector2.ZERO

signal facing_direction_changed(facing_right : bool)

func _ready():
	animation_tree.active = true
	$Sword.connect("hit_breakable", on_hit_breakable)
	$Sword.connect("hit_breakable_2", on_hit_breakable_2)
	$Sword.connect("hit_breakable_3", on_hit_breakable_3)
	$Sword.connect("hit_breakable_4", on_hit_breakable_4)
	$Sword.connect("hit_breakable_5", on_hit_breakable_5)

func _physics_process(delta):
	if not is_on_floor():
		# Add the gravity
		velocity.y += gravity * delta
	
	if Input.is_action_pressed("interact"):
		if is_over_button:
			emit_signal("press_button")
			emit_signal("open_trapdoor")
	
	# Get the input direction and handle the movement/deceleration
	direction = Input.get_vector("move_left", "move_right", "ui_up", "ui_down")
	
	if direction.x != 0 && state_machine.check_if_can_move():
		velocity.x = direction.x * speed
	elif state_machine.check_if_is_rolling():
		pass # do nothing, velocity is controlled in the roll function
	elif state_machine.current_state != hit_state:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	move_and_slide()
	update_animation_parameters()
	update_direction()

func update_animation_parameters():
	animation_tree.set("parameters/move/blend_position", direction.x)

func update_direction():
	if direction.x > 0:
		sprite.flip_h = false
	elif direction.x < 0:
		sprite.flip_h = true
	
	emit_signal("facing_direction_changed", !sprite.flip_h)

func _on_fallen_timer_timeout():
	get_tree().reload_current_scene()

func _on_button_body_entered(_body: Node2D):
	is_over_button = true

func _on_button_body_exited(_body: Node2D):
	is_over_button = false

func _on_end_game_area_body_entered(body: Node2D):
	if body.name == "player":
		end_game_timer.start(1)

func _on_end_game_timer_timeout():
		get_tree().change_scene_to_file("res://scenes/menus/end_game.tscn")

func _on_flare_flames_body_entered(body: Node2D):
	if body.name == "player":
		game_over_timer.start(1)

func _on_game_over_timer_timeout():
	get_tree().change_scene_to_file("res://scenes/menus/game_over.tscn")

func on_hit_breakable():
	emit_signal("break_object")
	
func on_hit_breakable_2():
	emit_signal("break_object_2")
	
func on_hit_breakable_3():
	emit_signal("break_object_3")
	
func on_hit_breakable_4():
	emit_signal("break_object_4")
	
func on_hit_breakable_5():
	emit_signal("break_object_5")
