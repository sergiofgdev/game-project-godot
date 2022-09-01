extends Node

export(int) var max_health = 1 setget set_max_health#Se puede especificar el tipo de variable
var health = max_health setget set_health #setter y getter

signal no_health
signal health_changed(value)
signal max_health_changed(value)

 
func set_max_health(value):
	max_health = value
	self.health = min(health,max_health)
	emit_signal("max_health_changed",max_health)

func set_health(value):
	health=value
	#Cuando la salud cambia emite una señal
	emit_signal("health_changed",health)
	#comprueba si tiene salud
	if health <=0:
		emit_signal("no_health")
	
 
func _ready():
	self.health = max_health
