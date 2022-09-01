extends Node2D

	
func _physics_process(delta):
	if $TextureButtonSalir.is_hovered() == true:
		$TextureButtonSalir.grab_focus()




func _on_TextureButtonSalir_pressed():
	get_tree().change_scene("res://PantallaTitulo.tscn")
