extends KinematicBody2D


# Declare member variables here. Examples:
export var dalmatian_child_distance = 200

# Nodes
onready var lifespan = get_node("Lifespan")

onready var game = get_tree().root.get_node("Game")

# Scenes
var dalmatian2_scene = preload("res://Scenes/Dalmatian2.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	lifespan.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func die():
	for i in 2:
		var dalmation2 = dalmatian2_scene.instance()
		
		if i == 1:
			dalmation2.global_position = global_position + Vector2(-dalmatian_child_distance, 0)
			dalmation2.get_node("Shooter").rotate_speed = -dalmation2.get_node("Shooter").rotate_speed
		else:
			dalmation2.global_position = global_position + Vector2(dalmatian_child_distance, 0)
		game.add_child(dalmation2)
		queue_free()

func _on_Lifespan_timeout():
	die()
