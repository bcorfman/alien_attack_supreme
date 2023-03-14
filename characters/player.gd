class_name Player
extends CharacterBody2D


const SHIP_SPEED = 300.0
const LASER_SPEED = 500.0
var firing = false
var firing_time = 1e20
var Laser = preload("res://characters/laser.tscn")

@onready var laser_origin = $LaserOrigin
@onready var laser_sound = $LaserSound

func _integrate_forces(s):
	var step = s.get_step()
	
	# A good idea when implementing characters of all kinds,
	# compensates for physics imprecision, as well as human reaction delay.
	var fire = Input.is_action_pressed("fire")
	if fire and not firing:
		call_deferred("_shot_laser")
	else:
		firing_time += step
		
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SHIP_SPEED * step
	else:
		velocity.x = 0
		
	move_and_collide(velocity)
	
func _shot_laser():
	firing_time = 0
	var li = Laser.instance()
	var pos = position + laser_origin.position * Vector2(0, -1.0)
	li.position = pos
	get_parent().add_child(li)
	li.linear_velocity = Vector2(0, -LASER_SPEED)
	laser_sound.play()
	add_collision_exception_with(li)
