extends Path2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Sets 4 random speeds and a rotation speed (in rad/s)
var speed = [randi()%500, randi()%500, randi()%500, randi()%500,]
var rot_speed = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	# Sets each PathFollow child in a random position of the track
	for child in get_children():
		child.unit_offset += rand_range(0, 1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var i = 0
	# Updates position on track and rotation of each child
	for child in get_children():
		child.offset += delta * speed[i]
		child.rotation += delta*rot_speed
		i += 1
