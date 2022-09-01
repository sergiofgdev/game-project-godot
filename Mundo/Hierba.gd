extends Node2D


const GrassEffect = preload("res://Efectos/EfectoHierba.tscn")

func create_grass_effect():
	var grassEffect = GrassEffect.instance() #En este caso hierbaEfecto es de tipo nodo
	#Ahora quiero instanciar el efecto de la hierba en el mundo
	
	get_parent().add_child(grassEffect)
	#Ahora vamos a indicar la posicion en la que queremos que se vea la animacion
	grassEffect.global_position = global_position #global_position es la posicion de nuestra hierba 

func _on_Hurtbox_area_entered(area):
	create_grass_effect()
	queue_free() #Pone en la cola un nodo para borrarse cuando se acabe el frame actual

