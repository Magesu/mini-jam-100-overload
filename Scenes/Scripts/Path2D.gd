extends Path2D


# Declare member variables here. Examples:
export var speed = 100

# Nodes
onready var chihuahua = get_node("PathFollow2D")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	chihuahua.offset += speed * delta
