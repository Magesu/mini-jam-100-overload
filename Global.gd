extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var scores=[]

# Called when the node enters the scene tree for the first time.
func _ready():
	scores.append(Score.new("[Dev] Fenisu", 275))
	scores.append(Score.new("[Dev] HappyPotatomato", 174))
	scores.append(Score.new("[Dev] Ceccro", 163))
	scores.append(Score.new("[Subject] Xofis", 148))
	scores.append(Score.new("[Subject] Mona Lisa", 128))
	scores.append(Score.new("[Dev] Pedestrek", 128))
	scores.append(Score.new("-", 0))
	scores.append(Score.new("-", 0))
	scores.append(Score.new("-", 0))
	scores.append(Score.new("-", 0))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func new_score(name_in, score_in):
	for i in range(0, 10):
		if scores[i].score_number < score_in:
			scores.insert(i, Score.new(name_in, score_in))
			break

class Score:
	var name: String
	var score_number: int
	
	func _init(name_in, number_in):
		self.name = name_in
		self.score_number = number_in
