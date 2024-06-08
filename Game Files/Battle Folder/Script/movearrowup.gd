extends Area2D

@onready var playerHealth = get_tree().current_scene.get_node("playerHealthBar")
@onready var enemyHealth = get_tree().current_scene.get_node("enemyHealthBar")
@onready var enemyHealth2 = get_tree().current_scene.get_node("enemyHealthBar2")
@onready var isPlayerTurn = get_tree().current_scene.isPlayerTurn
@onready var choice = get_tree().current_scene.choice

var isDoubleFirst = false
var isDoubleSecond = false
var secondify = true
var myPos = float(global_position.y)
var slashable = true

var canHurt = true

func _process(delta):
	# Move
	global_position.y += Global.noteSpeed * delta
	myPos += float(Global.noteSpeed * delta)
	
	if secondify:
		get_tree().call_group("up", "getOtherNotes", myPos)
	# Screen Exit
	if myPos > Global.hurtMargin and canHurt:
		canHurt = false
		Global.comboCounter = 0 
		if not isPlayerTurn:
			if choice == "Normal":
				playerHealth.value -= 4
			elif choice == "Easy":
				playerHealth.value -= 6
			elif choice == "NoEarly":
				playerHealth.value -= 2
			else:
				if Global.comboCounter > 35:
					playerHealth.value -= 3
				elif Global.comboCounter > 50:
					playerHealth.value -= 2
				elif Global.comboCounter > 70:
					playerHealth.value -= 0
				else:playerHealth.value -= 5
			get_tree().call_group("battle", "damageShake")
	
	if myPos > Global.disappearMargin and slashable:
		set_process(false)
		$Miss.show()
		$Miss.play("default")

func getOtherNotes(loc):
	if myPos - loc > 25 and myPos - loc < 75:
		isDoubleFirst = true
	if loc - myPos > 25 and loc - myPos < 75:
		isDoubleSecond = true

func unSecond():
	isDoubleSecond = false

func slash():
	if slashable:
		var hit = false
		if choice != "NoEarly":
			hit = myPos > Global.okMargin[0] and myPos < Global.okMargin[1]
		else:
			hit = myPos > Global.perfectMargin[0] and myPos < Global.greatMargin[1]
		
		if hit:
			Global.comboCounter += 1
			if isDoubleFirst:
				if myPos - Global.deadCenter > Global.magicalDoubleMargin:
					hit = false
					secondify = false
					get_tree().call_group("up", "unSecond")
			if isDoubleSecond:
				if Global.deadCenter - myPos > Global.magicalDoubleMargin:
					hit = false
		
		var perfectHit = myPos > Global.perfectMargin[0] and myPos < Global.perfectMargin[1]
		var greatHit = (myPos >=  Global.greatMargin[0] and myPos <=  Global.perfectMargin[0]) or (myPos <=  Global.greatMargin[1] and myPos >=  Global.perfectMargin[1])
		var okHit = (myPos >=  Global.okMargin[0] and myPos <=  Global.greatMargin[0]) or (myPos <=  Global.okMargin[1] and myPos >=  Global.greatMargin[1])
		
		if hit:
			set_process(not is_processing())
			$Sprite2D.play("default")
			get_tree().call_group("idleup", "register")
			var amount = 0
			if perfectHit:
				amount = 1.5
				$Perfect.show()
				$Perfect.play("default")
			elif greatHit:
				amount = 1
				$Great.show()
				$Great.play("default")
			elif okHit:
				amount = .5
				$Ok.show()
				$Ok.play("default")
			if choice == "NoEarly":
				amount += .5
			if choice == "Combo":
				if Global.comboCounter < 50:
					amount *= 0.5
				elif Global.comboCounter >= 85:
					amount *= 2
				elif Global.comboCounter >= 50:
					amount *= .5
			dealDamage(amount)
			
			if isPlayerTurn:
				var animation
				if perfectHit:
					animation = $Perfect
				elif greatHit:
					animation = $Great
				elif okHit:
					animation = $Ok
				animation.rotation = -0.645771823
				var speed = 15
				while true:
					animation.position.x += speed * 0.79863551
					animation.position.y -= speed * 0.601815023
					await get_tree().create_timer(.01).timeout

func dealDamage(number):
	if isPlayerTurn:
		if enemyHealth.value > 0:
			enemyHealth.value -= number
			if enemyHealth.value < 0:
				enemyHealth2.value += enemyHealth.value
		else:
			enemyHealth2.value -= number

func _on_sprite_2d_animation_looped():
	$Sprite2D.hide()
	slashable = false

func killSelf():
	queue_free()

func _on_miss_animation_looped():
	queue_free()

func _on_perfect_animation_looped():
	queue_free()

func _on_great_animation_looped():
	queue_free()

func _on_ok_animation_looped():
	queue_free()
