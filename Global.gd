extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var scores=[]

# Called when the node enters the scene tree for the first time.
func _ready():
	scores.append(Score.new("NomeA", 20))
	scores.append(Score.new("NomeB", 18))
	scores.append(Score.new("NomeC", 16))
	scores.append(Score.new("NomeD", 14))
	scores.append(Score.new("NomeE", 12))
	scores.append(Score.new("NomeF", 10))
	scores.append(Score.new("NomeG", 8))
	scores.append(Score.new("NomeH", 6))
	scores.append(Score.new("NomeI", 4))
	scores.append(Score.new("NomeJ", 2))
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
