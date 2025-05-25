extends Control

var score: int = 0
var combo_count: int = 0

func _ready() -> void:
	Signals.IncrementScore.connect(IncrementScore)
	Signals.IncrementCombo.connect(IncrementCombo)
	Signals.ResetCombo.connect(ResetCombo)
	
func IncrementScore(incr: int):
	score += incr
	%ScoreLabel.text = " "+ str(score) + " pts"

func IncrementCombo():
	combo_count += 1
	%ComboLabel.text = " " + "x" + str(combo_count) + " combo"

func ResetCombo():
	combo_count = 0
	%ComboLabel.text = ""
