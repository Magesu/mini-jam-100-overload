extends MarginContainer


# Declare member variables here. Examples:

# Nodes
onready var main = get_tree().get_root().get_node("Main")

# Getting number box nodes
onready var rotate_speed_spin_box = get_node("VBoxContainer/PanelContainer/HBoxContainer/RotateSpeedSpinBox")
onready var timer_wait_time_spin_box = get_node("VBoxContainer/PanelContainer2/HBoxContainer/TimerWaitTimeSpinBox")
onready var spawnpoint_number_spin_box = get_node("VBoxContainer/PanelContainer3/HBoxContainer/SpawnpointNumberSpinBox")
onready var radius_spin_box = get_node("VBoxContainer/PanelContainer4/HBoxContainer/RadiusSpinBox")
onready var bullet_speed_spin_box = get_node("VBoxContainer/PanelContainer5/HBoxContainer/BulletSpeedBox")
onready var turns_checkbutton = get_node("VBoxContainer/PanelContainer6/HBoxContainer/TurnsCheckButton")
onready var turn_timer_spin_box = get_node("VBoxContainer/PanelContainer7/HBoxContainer/TurnTimerWaitTime")

# Called when the node enters the scene tree for the first time.
func _ready():
	# Connecting all the value changed signals to the main when this scene is loaded
	rotate_speed_spin_box.connect("value_changed",main,"_on_RotateSpeedSpinBox_value_changed")
	timer_wait_time_spin_box.connect("value_changed",main,"_on_TimerWaitTimeSpinBox_value_changed")
	spawnpoint_number_spin_box.connect("value_changed",main,"_on_SpawnpointNumberSpinBox_value_changed")
	radius_spin_box.connect("value_changed",main,"_on_RadiusSpinBox_value_changed")
	bullet_speed_spin_box.connect("value_changed",main,"_on_BulletSpeedSpinBox_value_changed")
	turns_checkbutton.connect("toggled",main,"_on_TurnsCheckButton_toggled")
	turn_timer_spin_box.connect("value_changed",main,"_on_TurnTimerWaitTime_value_changed")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
