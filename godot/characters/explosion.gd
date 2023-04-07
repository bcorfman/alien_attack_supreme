extends RigidBody2D

@onready var sound = $Sound

func _ready():
	sound.play()
