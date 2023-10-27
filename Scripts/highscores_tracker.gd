extends Node

var save_path = "user://score.save"
@export var scores: Array = load_scores()

class ScoreSorter:
	static func sort_scores(a,b):
		return a['score'] > b['score']
		
signal score_added

func save_scores(scores):
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(scores)
	file.close()
	
func load_scores():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		var scores = file.get_var()
		file.close()
		return scores
	else:
		var initial_scores = []
		for i in range(10):
			initial_scores.append({"initials": "AAA", "score": 0000})
		save_scores(initial_scores)
		return initial_scores

func add_score(initials, score):
	scores = load_scores()
	scores.append({"initials": initials, "score": score})
	var sorter = ScoreSorter.new()
	scores.sort_custom(sorter.sort_scores)
	if scores.size() > 10:
		scores.resize(10)  
	save_scores(scores)
	scores = load_scores()
	emit_signal("score_added")
