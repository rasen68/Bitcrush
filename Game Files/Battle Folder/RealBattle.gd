extends Node2D

signal GoodHit

# Instances of each note
const arrow = preload("res://Battle Folder/move_arrow.tscn")

const riaHurtFace = preload("res://Battle Folder/Sprite/RiaHeadHurt.png")
const riaRegularFace = preload("res://Intro Folder/RiaHead.png")
const riaFocusedFace = preload("res://Intro Folder/riaheadfocus.png")

var shaking = false
var leftHit = false
var upHit = false
var downHit = false
var rightHit = false

# Note Times (Easier Map)
var noteOneTimes = [8833, 10166, 14500, 17500, 17667, 20166, 22166, 24166, 25833, 29500, 30166, 31500, 32166, 40611, 41500, 43500, 45833, 46500, 47166, 47833, 48166, 50833, 52166, 53500, 55166, 55833, 58500, 60666, 62166, 64833, 65500, 68500, 70833, 72166, 73500, 74833, 80666, 81666, 82833, 84166, 85500, 86833, 89500, 92166, 93500, 94833, 98166, 98833, 102833, 103500, 105500, 106166, 108166, 112166, 113500, 115500, 128166, 129500, 129833, 132166, 132500, 134166, 135333, 135500, 140166, 146833, 148166, 150000, 153500, 155166, 155333, 158500, 159000, 178833, 182833, 184500, 184833, 185500, 187500, 189500, 191166, 191833, 193166, 194833, 196166, 199833, 200166, 201000, 201833, 203833, 204166, 205500, 205833, 207166, 208833, 209500, 209833, 212000, 212500, 1000166]
var noteTwoTimes = [6166, 8166, 8667, 9833, 14000, 14833, 16667, 16833, 19500, 20166, 21500, 22833, 23500, 24166, 25500, 26166, 27500, 27833, 28166, 28833, 29500, 30166, 30833, 32166, 37833, 40333, 40833, 41833, 42500, 43500, 44500, 45166, 46833, 47500, 49333, 50666, 52166, 52833, 53833, 54833, 56500, 56833, 58166, 59833, 60833, 61500, 62833, 66833, 67000, 67833, 69166, 70833, 71500, 72833, 74833, 80833, 81500, 83500, 85500, 86833, 88166, 90833, 94833, 96166, 97500, 100166, 101500, 102833, 105500, 106833, 108166, 108833, 110166, 110833, 112166, 113500, 114166, 114833, 116166, 116833, 129166, 130166, 131833, 132833, 136166, 136333, 142833, 145500, 149833, 150166, 151500, 151833, 152166, 153666, 154000, 154166, 155000, 155833, 158000, 158833, 159166, 173500, 183500, 183833, 184333, 186833, 187166, 188166, 190500, 191500, 193000, 193833, 194500, 195166, 196500, 197500, 198166, 198500, 198833, 199666, 200333, 200833, 201166, 202166, 202500, 204000, 204500, 206666, 208166, 209166, 210166, 210833, 211500, 213500, 1000166]
var noteThreeTimes = [5500, 6833, 9500, 10500, 11500, 12833, 14166, 15166, 15833, 16166, 16333, 17167, 17333, 18500, 18666, 19500, 20833, 22166, 22833, 23500, 25166, 26500, 26833, 27333, 29166, 29500, 30166, 30833, 31500, 32166, 37500, 38166, 38833, 39500, 40166, 42833, 44166, 44833, 46833, 47500, 48333, 51500, 54500, 56166, 57500, 57833, 58833, 59500, 60333, 61500, 64166, 64500, 65166, 66166, 67333, 67500, 68833, 70833, 71500, 73500, 74166, 74833, 80333, 81333, 82666, 85500, 86833, 89500, 90833, 93500, 96833, 99500, 100166, 102166, 104166, 104833, 106833, 109500, 111500, 117500, 128833, 130500, 131500, 133166, 134666, 134833, 136666, 136833, 137833, 138500, 141500, 144166, 146833, 149666, 151333, 152333, 154500, 154833, 155500, 156500, 157166, 157500, 159333, 159666, 176166, 182500, 183166, 184166, 185833, 186666, 187833, 188333, 189666, 190166, 190833, 193500, 194166, 195500, 195833, 196833, 197333, 197833, 199000, 199500, 200500, 201666, 204333, 204833, 206166, 207833, 208166, 208500, 210500, 213166, 1000166]
var noteFourTimes = [7500, 9167, 10833, 12166, 13500, 15500, 20833, 21500, 22833, 24833, 27000, 29500, 30833, 31500, 32166, 41166, 42166, 42833, 45500, 46166, 47166, 47833, 49166, 50500, 50833, 51500, 52833, 54166, 55500, 57166, 59166, 60166, 61166, 62166, 62833, 64166, 68166, 70833, 72166, 72833, 74166, 74833, 80166, 81166, 82500, 83500, 84833, 85500, 86833, 88166, 92166, 93500, 94833, 96166, 97500, 98833, 100833, 101500, 104166, 107500, 109500, 110833, 112833, 114833, 116166, 117500, 128166, 128500, 130833, 131166, 133500, 133833, 137166, 137500, 138166, 138833, 145500, 148166, 149500, 150500, 150833, 152500, 152833, 153166, 156166, 156833, 158166, 159833, 170833, 181500, 182333, 183000, 185166, 186500, 187666, 188500, 189833, 190333, 191666, 192166, 192500, 192833, 193500, 197166, 198333, 199166, 201500, 202333, 202833, 203166, 203500, 205166, 206500, 211166, 211500, 1000166]

var easyRemovedOne = [8833, 17667, 22166, 24166, 29500, 32166, 43500, 47833, 50833, 52166, 70833, 73500, 74833, 81666, 85500, 86833, 92166, 93500, 94833, 98833, 128166, 135500, 148166, 150000, 155333, 159000, 201000]
var easyRemovedTwo =[16833, 20166, 27500, 29500, 30166, 30833, 32166, 40333, 40833, 46833, 47500, 49333, 50666, 52833, 60833, 62833, 67000, 74833, 80833, 85500, 88166, 90833, 94833, 97500, 102833, 105500, 106833, 108166, 112166, 113500, 136333, 145500, 151500, 153666, 154166, 155000, 184333, 193000, 199666, 200333, 204000, 206666, 211500]
var easyRemovedThree = [14166, 16333, 17333, 18666, 19500, 20833, 22833, 23500, 30166, 30833, 31500, 32166, 42833, 48333, 51500, 60333, 61500, 64166, 67500, 70833, 71500, 74833, 80333, 81333, 82666, 85500, 86833, 89500, 93500, 100166, 104166, 109500, 117500, 134833, 136833, 146833, 149666, 152333, 159333, 182500, 186666, 188333, 189666, 197333, 199000, 201666, 204333, 208166]
var easyRemovedFour = [21500, 22833, 27000, 29500, 31500, 47166, 62166, 70833, 72166, 72833, 74166, 83500, 86833, 96166, 101500, 110833, 114833, 116166, 158166, 159833, 183000, 187666, 190333, 191666, 193500, 198333, 202333]

var countOne = 0
var countTwo = 0
var countThree = 0
var countFour = 0
var isPlayerTurn = true
var isBreak = true
var choice = "Normal"

var startTime = Time.get_ticks_msec()
var milliSecDelay = 2000
var songMeterSprites = []
var songMeterSeconds = []
var songMeterCounter = 0
var numNotes = []
@onready var playerHealthBar = $playerHealthBar
@onready var enemyHealthBar = $enemyHealthBar
@onready var enemyHealthBar2 = $enemyHealthBar2
@onready var riaFacePosition = $RiaFace.position


# Start of scene
func _ready():
	for sprite in $SongMeter.get_children():
		songMeterSprites.append(sprite)
	var count = 0
	while count <= 33:
		songMeterSeconds.append(count * 6390)
		count += 1
	if Global.fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	$RiaVsAdin.play()
	$Create/Position2D_AL/Sprite2D.show()
	$Create/Position2D_AU/Sprite2D.show()
	$Create/Position2D_AD/Sprite2D.show()
	$Create/Position2D_AR/Sprite2D.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# Check to make sure song is playing
	if not $RiaVsAdin.playing:
		$RiaVsAdin.play()
	
	# Keep track of milliseconds gone by
	var milliTime = Time.get_ticks_msec() - startTime
	
	enemyHealthBarVisible()
	
	# Ensure neither enemy or player can lose health in first few seconds
	if milliTime < 5000:
		enemyHealthBar.value = 150 # If enemy's max health is changed, this must be adjusted
		enemyHealthBar2.value = 150 # If enemy's max health is changed, this must be adjusted
		playerHealthBar.value = 100 # If player's max health is changed, this must be adjusted
	
	# Alternate enemy and player's turns
	timeCheck(milliTime)
	# Create new moving notes

	$ComboCounter.text = str(Global.comboCounter) 
	noteOneCheck(milliTime)
	noteTwoCheck(milliTime)
	noteThreeCheck(milliTime)
	noteFourCheck(milliTime)

	if Global.comboCounter > 50:
		$RiaFace.texture = riaFocusedFace
	else:
		$RiaFace.texture = riaRegularFace
	
	# Update song meter
	if songMeterCounter < 32:
		if milliTime > songMeterSeconds[songMeterCounter]:
			songMeterSprites[songMeterCounter].hide()
			songMeterSprites[songMeterCounter + 1].show()
			songMeterCounter += 1
	
	# Check if player is dead
	if playerHealthBar.value == 0:
		playerHealthBar.value = 100
		get_tree().call_group("down", "killSelf")
		get_tree().call_group("up", "killSelf")
		get_tree().call_group("left", "killSelf")
		get_tree().call_group("right", "killSelf")
		get_tree().change_scene_to_file("res://gameover.tscn")

func _input(event):
	if event is InputEventKey and event.pressed:
		Global.inputEvent = event.keycode
		if event.keycode == Global.keybinds[0]:
			get_tree().call_group("left", "slash")
			if leftHit:
				leftHit = false
			else:
				$Create/Position2D_AL/AnimationPlayer.play("wrongnote")
		
		if event.keycode == Global.keybinds[1]:
			get_tree().call_group("up", "slash")
			if upHit:
				upHit = false
			else:
				$Create/Position2D_AU/AnimationPlayer.play("wrongnote")
		
		if event.keycode == Global.keybinds[2]:
			get_tree().call_group("down", "slash")
			if downHit:
				downHit = false
			else:
				$Create/Position2D_AD/AnimationPlayer.play("wrongnote")
		
		if event.keycode == Global.keybinds[3]:
			get_tree().call_group("right", "slash")
			if rightHit:
				rightHit = false
			else:
				$Create/Position2D_AR/AnimationPlayer.play("wrongnote")

func registerleft():
	leftHit = true

func registerup():
	upHit = true

func registerdown():
	downHit = true

func registerright():
	rightHit = true

func enemyHealthBarVisible():
	if enemyHealthBar.value <= 0:
		$"2x health bar".hide()
		$"1x health bar".show()

func noteOneCheck(currentTime):
	if countOne < len(noteOneTimes):
		if currentTime >= noteOneTimes[countOne] - milliSecDelay:
			if not (choice == "Easy" and noteOneTimes[countOne] in easyRemovedOne):
				var al = arrow.instantiate()
				get_parent().add_child(al)
				al.global_position = $Create/Position2D_AL.global_position
				al.add_to_group("left")
				get_tree().call_group("left", "makeGroup", "left")
			countOne += 1

func noteTwoCheck(currentTime):
	if countTwo < len(noteTwoTimes):
		if currentTime >= noteTwoTimes[countTwo] - milliSecDelay:
			if not (choice == "Easy" and noteTwoTimes[countTwo] in easyRemovedTwo):
				var au = arrow.instantiate()
				get_parent().add_child(au)
				au.global_position = $Create/Position2D_AU.global_position
				au.add_to_group("up")
				get_tree().call_group("up", "makeGroup", "up")
			countTwo += 1

func noteThreeCheck(currentTime):
	if countThree < len(noteThreeTimes):
		if currentTime >= noteThreeTimes[countThree] - milliSecDelay:
			if not (choice == "Easy" and noteThreeTimes[countThree] in easyRemovedThree):
				var ad = arrow.instantiate()
				get_parent().add_child(ad)
				ad.global_position = $Create/Position2D_AD.global_position
				ad.add_to_group("down")
				get_tree().call_group("down", "makeGroup", "down")
			countThree += 1

func noteFourCheck(currentTime):
	if countFour < len(noteFourTimes):
		if currentTime >= noteFourTimes[countFour] - milliSecDelay:
			if not (choice == "Easy" and noteFourTimes[countFour] in easyRemovedFour):
				var ar = arrow.instantiate()
				get_parent().add_child(ar)
				ar.global_position = $Create/Position2D_AR.global_position
				ar.add_to_group("right")
				get_tree().call_group("right", "makeGroup", "right")
			countFour += 1

func playerTurn():
	isBreak = false
	isPlayerTurn = true
	$RiaFace/RiaTurnBackground.visible = true
	$AdinFace/AdinTurnBackground.visible = false

func enemyTurn():
	isBreak = false
	isPlayerTurn = false
	$RiaFace/RiaTurnBackground.visible = false
	$AdinFace/AdinTurnBackground.visible = true

func damageShake():
	if not shaking:
		shaking = true
		$RiaFace.texture = riaHurtFace
		$RiaFace.position += Vector2(-1.5, -3.5)
		await get_tree().create_timer(.15).timeout
		$RiaFace.position += Vector2(2, -1)
		await get_tree().create_timer(.15).timeout
		$RiaFace.position += Vector2(-3, -1)
		await get_tree().create_timer(.15).timeout
		$RiaFace.position += Vector2(-1.5, -2.5)
		await get_tree().create_timer(.15).timeout
		$RiaFace.position += Vector2(-2, -1)
		await get_tree().create_timer(.15).timeout
		$RiaFace.position += Vector2(-0.5, -0.5)
		await get_tree().create_timer(.15).timeout
		$RiaFace.position = riaFacePosition
		$RiaFace.texture = riaRegularFace
		shaking = false

func songBreak():
	if isBreak:
		$ChoiceBox.visible = true
		choiceSelect()
	else:
		$ChoiceBox.visible = false
	

func timeCheck(milliTime):
	if milliTime < 4800:
		isBreak = true
		songBreak()
	elif milliTime < 32500:
		playerTurn()
		songBreak()
	elif milliTime < 36500:
		isBreak = true
		songBreak()
	elif milliTime < 75500:
		enemyTurn()
		songBreak()
	elif milliTime < 79500:
		isBreak = true
		songBreak()
	elif milliTime < 118500:
		playerTurn()
		songBreak()
	elif milliTime < 127500:
		isBreak = true
		songBreak()
	elif milliTime < 161500:
		enemyTurn()
		songBreak()
	elif milliTime < 169000:
		isBreak = true
		songBreak()
	elif milliTime < 218500:
		playerTurn()
		songBreak()
	else:
		if enemyHealthBar2.value == 0:
			get_tree().change_scene_to_file("res://Battle Folder/playerWin.tscn")
		else:
			get_tree().reload_current_scene()

func choiceSelect():
	if Global.inputEvent == Global.keybinds[0]:
		choice = "Easy"
		$ChoiceBox/Easy/EasySelected.visible = true
		$ChoiceBox/Normal/NormalSelected.visible = false
		$ChoiceBox/NoEarly/NoEarlySelected.visible = false
		$ChoiceBox/Combo/ComboSelected.visible = false
	if Global.inputEvent == Global.keybinds[1]:
		choice = "Normal"
		$ChoiceBox/Easy/EasySelected.visible = false
		$ChoiceBox/Normal/NormalSelected.visible = true
		$ChoiceBox/NoEarly/NoEarlySelected.visible = false
		$ChoiceBox/Combo/ComboSelected.visible = false
	if Global.inputEvent == Global.keybinds[2]:
		choice = "NoEarly"
		$ChoiceBox/Easy/EasySelected.visible = false
		$ChoiceBox/Normal/NormalSelected.visible = false
		$ChoiceBox/NoEarly/NoEarlySelected.visible = true
		$ChoiceBox/Combo/ComboSelected.visible = false
	if Global.inputEvent == Global.keybinds[3]:
		choice = "Combo"
		$ChoiceBox/Easy/EasySelected.visible = false
		$ChoiceBox/Normal/NormalSelected.visible = false
		$ChoiceBox/NoEarly/NoEarlySelected.visible = false
		$ChoiceBox/Combo/ComboSelected.visible = true
