extends CanvasLayer

func _ready():
	$GameOver.play()

func _on_retry_pressed():
	get_tree().change_scene_to_file("res://Battle Folder/RealBattle.tscn")


func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://Menu Folder/menu.tscn")
