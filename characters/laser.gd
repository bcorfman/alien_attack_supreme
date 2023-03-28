class_name Laser
extends RigidBody2D

var parent_object

@onready var sound = $Sound

func _ready():
	sound.play()
	
func on_body_entered(body):
	parent_object.delete_shot(self)
	queue_free()
	hide()
	if body.name == "Enemy1":
		body.get_node("AnimationPlayer").play("explode")
