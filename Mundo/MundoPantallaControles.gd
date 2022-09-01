extends Node2D




	
func _physics_process(delta):
	if $TextureButtonVolver.is_hovered() == true:
		$TextureButtonVolver.grab_focus()


func _on_TextureButtonVolver_pressed():
	get_tree().change_scene("res://PantallaTitulo.tscn")
