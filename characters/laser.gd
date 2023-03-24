class_name Laser
extends RigidBody2D

var parent_object

@onready var sound = $Sound

func _ready():
	sound.play()
	
func _on_body_entered(_body):
	parent_object.delete_shot(self)
	queue_free()
	hide()
	print(parent_object.shots.size())
