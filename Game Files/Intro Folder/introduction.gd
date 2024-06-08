extends Control

# Define array variable that holds script and animation sequence
var introSceneScript = [ 
 #[0, "Scene"],
 ["What the fuck where did it go.", "Ria"],
 #[1, "Scene"], 
 ["You’re kidding me, I’ve got studio time literally tomorrow morning!", "Ria"],
 #[2, "Mad"],
 ["Oh yeah, someone broke in a few hours ago and stole it. I tried to stop them...", "Maddie"],
 ["Fuck girl, I need that shit...", "Ria"],
 #[3, "Mad"],
 ["Course you do, which is why I gotchu covered!", "Maddie"],
 ["I’ve got at least one lead thanks to a bit of arcane analysis and dumb luck.", "Maddie"],
 ["Remember Adin, himbo tennis guy from sophomore year who totally tried to play both of us?", "Maddie"],
 ["Apparently his new band is playing at Franklin Music Hall in 30 minutes, but where did he get... a band?", "Maddie"],
 #[4, "Scene"],
 ["Maybe he’s using some magic combined with your Legendary-rarity guitar to pretend that he can shred.", "Maddie"],
 ["I see, I see... no yeah that motherfucker would totally. He knew my guitar skills kicked ass too! Means, method, opportunity.", "Ria"],
 #[5, "Ri"],
 ["You addressed none of those things, but so true bestie. Even if it’s not him, he’s got to have some intel.", "Maddie"],
 ["That guy knows just about everyone in the world of assholes and organised petty theft.", "Maddie"],
 ["Let's roll out. By that I mean just you-", "Maddie"],
 ["Can I fast travel?", "Ria"],
 #[6, "Mad"],
 ["Just this one, I set up a teleporter for you.", "Maddie"],
 ["I'mma kick his ass!", "Ria"],
 [7, "Change"],
 ["Is this the right place?", "Ria"],
 [8, "Scene"],
 ["... what the fuck?", "Ria"],
 #[9, "Scene"],
 ["I don't know what's going on...", "Ria"],
 ["But it might help and I feel personally well within my right to beat the shit out of you!", "Ria"],
 #[10, "Ri"],
 ["Hey listen! Well I guess you were never the type... oh well, I guess I've got no choice.", "Adin"],
 [9, "Exit"] 
]

# Define variable to keep track of script position
var scriptIndex = 0

@onready var person_label = $Control/PersonLabel
@onready var the_label = $Control2/Label
@onready var timer = $Read_Out_Diologue_Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	set_process_input(true)
	$RiaRoom.play()
	$TextureRect2.hide()
	$Adin_Sprite.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

# Define mouse click function to progress through script
func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if introSceneScript[scriptIndex][1] == "Ria":
			$MadelineHead.visible = false
			$AdinHead.visible = false
			$RiaHead.visible = true
		elif introSceneScript[scriptIndex][1] == "Maddie":
			$AdinHead.visible = false
			$RiaHead.visible = false
			$MadelineHead.visible = true
		elif introSceneScript[scriptIndex][1] == "Adin":
			$MadelineHead.visible = false
			$RiaHead.visible = false
			$AdinHead.visible = true
		else:
			$MadelineHead.visible = false
			$RiaHead.visible = false
			$AdinHead.visible = false
			the_label.text = ""
		if introSceneScript[scriptIndex][0] is String:
			person_label.text = introSceneScript[scriptIndex][1]
			the_label.text = ""
			read_dialogue(introSceneScript[scriptIndex][0])
		elif introSceneScript[scriptIndex][1] == "Change":
			$RiaRoomBackground.hide()
			$StageRoomBackground2.show()
			$Madeline_Sprite.hide()
			$Adin_Sprite.show()
		elif introSceneScript[scriptIndex][0] == 8:
			$StageRoomBackground2.hide()
			$LitStageBackground.show()
		
		elif introSceneScript[scriptIndex][1] == "Exit":
			get_tree().change_scene_to_file("res://Battle Folder/RealBattle.tscn")
		else:
			pass
		scriptIndex += 1

# Define function to display text into label
func read_dialogue(text):
	var the_text = text.split()
	var character = 0
	set_process_input(false)
	while character < len(the_text):
		timer.start(.015)
		await timer.timeout
		the_label.text += the_text[character]
		character += 1
	set_process_input(true)

