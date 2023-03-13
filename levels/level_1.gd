extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var screenRect = get_viewport().get_visible_rect()
	$Player.position = Vector2(screenRect.get_center().x, screenRect.size.y - 70)
