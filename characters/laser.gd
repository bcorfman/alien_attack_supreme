class_name Laser
extends RigidBody2D

var parent_object

@onready var sound = $Sound

func _ready():
	sound.play()
	
func on_body_entered(body):
	parent_object.delete_shot(self)
	hide()
	queue_free()
	if body.name == "Enemy1":
		body.get_node("AnimationPlayer").stop(true)
		body.start_explosions(body.position, body.get_node("Ship").get_rect().size.x)
