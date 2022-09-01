extends AnimatedSprite


func _ready():
	connect("animation_finished",self,"_on_animation_finished")
	frame=0 #Establecemos el frame en 0 porque si no empieza directamente en el ultimo frame y no hay animacion
	play("Animate")
	


#Funcion generada a partir de un Signal, de este modo indicamos que hacer cuando acabe la animación
func _on_animation_finished():
	queue_free()
	

