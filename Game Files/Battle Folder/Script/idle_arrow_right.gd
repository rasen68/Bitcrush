extends Area2D

@onready var animp = $AnimationPlayer
var noteHit = false

func _ready():
	animp.set_speed_scale(10)

func _input(event):
	if event is InputEventKey and event.pressed:
		Global.inputEvent = event.keycode
		if event.keycode == Global.keybinds[3]:
			get_tree().call_group("right", "slash")
			if noteHit:
				noteHit = false
			else:
				animp.play("Bad")

func register():
	noteHit = true
