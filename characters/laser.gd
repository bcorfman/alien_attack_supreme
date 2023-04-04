class_name Laser
extends RigidBody2D

var parent_object
var enemy
@onready var sound = $Sound

func _ready():
	sound.play()
	
func on_body_entered(body):
	hide()
	if body.name == "Enemy1":
		enemy = body
		enemy.get_node("Enemy1Collision").set_deferred("disabled", true)
		enemy.connect("explosions_finished", destroy_enemy)
		enemy.call_deferred("start_explosions")
		
func destroy_enemy():		
	#enemy.get_node("AnimationPlayer").stop(true)
	enemy.hide()
	enemy.queue_free()
	parent_object.delete_shot(self)
	queue_free()  
