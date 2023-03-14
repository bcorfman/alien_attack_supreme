class_name Laser
extends RigidBody2D

var disabled = false

# Called when the node enters the scene tree for the first time.
func _ready():
	($Timer as Timer).start()


func disable():
	if disabled:
		return
		
	($AnimationPlayer as AnimationPlayer).play("shutdown")
	disabled = true
