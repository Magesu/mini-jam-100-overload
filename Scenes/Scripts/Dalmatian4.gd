extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Nodes
onready var game = get_tree().root.get_node("Game")
onready var lifespan = get_node("Lifespan")

# Scenes
var next_boss_scene = preload("res://Scenes/Fluffy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	lifespan.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func die():
	var next_boss = next_boss_scene.instance()
	next_boss.global_position = global_position
	game.add_child(next_boss)
	queue_free()

func _on_Lifespan_timeout():
	die()
