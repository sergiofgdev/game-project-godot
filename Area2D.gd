extends Area2D

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Jugador":
			get_tree().change_scene("res://MundoPlanta1.tscn")
