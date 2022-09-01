extends Control

var hearts = 6 setget set_hearts
var max_hearts = 6 setget set_max_hearts


onready var heartUIFull = $HeartUIFull
onready var heartUIEmpty = $HeartUIEmpty


func set_hearts(value):
	hearts = clamp(value,0,max_hearts) #Nuestros corazones nunca seran menos de 0 y mas de 4
	if heartUIFull != null:
		heartUIFull.rect_size.x = hearts * 15 #15 viene del numero de pixels que tiene el corazon en horizontal
		

func set_max_hearts(value):
	max_hearts = max(value,1) #Nunca pueden ser menos de 1
	self.hearts= min(hearts, max_hearts)
	if heartUIEmpty != null:
		heartUIEmpty.rect_size.x = hearts * 15 

func _ready():
	self.max_hearts = PlayerStats.max_health
	self.hearts = PlayerStats.health
	#Conectamos la señal
# warning-ignore:return_value_discarded
	PlayerStats.connect("health_changed",self,"set_hearts")
# warning-ignore:return_value_discarded
	PlayerStats.connect("max_health_changed",self,"set_max_hearts")
	
 
