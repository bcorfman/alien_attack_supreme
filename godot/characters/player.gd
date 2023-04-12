class_name Player
extends RigidBody2D

const SHIP_SPEED = 300.0
const LASER_SPEED = 500.0
var colliding
var Laser = preload("res://characters/laser.tscn")
var shots = []
var fire
var direction

@onready var timer: Timer = $Timer
	
func _input(_event):
	fire = Input.is_action_pressed(&"fire")	
	direction = Input.get_axis(&"move_left", &"move_right")
	
func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	var velocity := state.get_linear_velocity()
	
	if fire and timer.is_stopped():
		call_deferred("_shoot_laser")
		
	if direction:
		velocity.x = direction * SHIP_SPEED 
	else:
		velocity.x = 0
	
	state.set_linear_velocity(velocity)

func _shoot_laser():
	var li = Laser.instantiate()
	shots.append(li)
	li.parent_object = self
	li.visible = true
	li.gravity_scale = 0
	li.body_entered.connect(li.on_body_entered)
	var pos = position + li.get_node("Origin").position * Vector2(0, -1.0)
	li.position = pos
	get_parent().add_child(li)
	li.linear_velocity = Vector2(0, -LASER_SPEED)
	add_collision_exception_with(li)
	timer.start()
	
func delete_shot(laser: Laser):
	var index = shots.find(laser)
	if index > -1:
		shots.remove_at(index)
