extends HBoxContainer

@onready var filledheart = preload("res://filled_heart.tscn").instantiate().texture
@onready var emptyHeart = preload("res://empty_heart.tscn").instantiate().texture
@onready var heart1 = $Heart1
@onready var heart2 = $Heart2
@onready var heart3 = $Heart3

func _physics_process(delta):
	updateHearts()

func updateHearts():
	if Global.playerHealth == 3:
		heart1.texture = filledheart
		heart2.texture = filledheart
		heart3.texture = filledheart
		
	if Global.playerHealth == 2:
		heart1.texture = filledheart
		heart2.texture = filledheart
		heart3.texture = emptyHeart
		
	if Global.playerHealth == 1:
		heart1.texture = filledheart
		heart2.texture = emptyHeart
		heart3.texture = emptyHeart
