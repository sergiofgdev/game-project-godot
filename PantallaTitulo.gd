extends Node2D



func _ready():
	$TextureButtonInicio.grab_focus()


func _physics_process(delta):
	if $TextureButtonInicio.is_hovered() == true:
		$TextureButtonInicio.grab_focus()
	if $TextureButtonSalir.is_hovered() == true:
		$TextureButtonSalir.grab_focus()
	if $TextureButtonControles.is_hovered() == true:
		$TextureButtonControles.grab_focus()
	


func _on_TextureButtonInicio_pressed():
	get_tree().change_scene("res://Mundo.tscn")


func _on_TextureButtonSalir_pressed():
	get_tree().quit()
	

func _on_TextureButtonControles_pressed():
	get_tree().change_scene("res://Mundo/MundoPantallaControles.tscn")
