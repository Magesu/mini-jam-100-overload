extends MarginContainer


# Declare member variables here. Examples:

# Nodes
onready var main = get_tree().get_root().get_node("Main")

# Getting number box nodes
onready var rotate_speed_spin_box = get_node("VBoxContainer/RotateSpeed/HBoxContainer/RotateSpeedSpinBox")
onready var timer_wait_time_spin_box = get_node("VBoxContainer/TimerWaitTime/HBoxContainer/TimerWaitTimeSpinBox")
onready var spawnpoint_number_spin_box = get_node("VBoxContainer/SpawnpointNumber/HBoxContainer/SpawnpointNumberSpinBox")
onready var radius_spin_box = get_node("VBoxContainer/Radius/HBoxContainer/RadiusSpinBox")
onready var bullet_speed_spin_box = get_node("VBoxContainer/BulletSpeed/HBoxContainer/BulletSpeedBox")

# Called when the node enters the scene tree for the first time.
func _ready():
	# Connecting all the value changed signals to the main when this scene is loaded
	rotate_speed_spin_box.connect("value_changed",main,"_on_RotateSpeedSpinBox_value_changed")
	timer_wait_time_spin_box.connect("value_changed",main,"_on_TimerWaitTimeSpinBox_value_changed")
	spawnpoint_number_spin_box.connect("value_changed",main,"_on_SpawnpointNumberSpinBox_value_changed")
	radius_spin_box.connect("value_changed",main,"_on_RadiusSpinBox_value_changed")
	bullet_speed_spin_box.connect("value_changed",main,"_on_BulletSpeedSpinBox_value_changed")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
