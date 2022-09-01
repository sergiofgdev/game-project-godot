extends KinematicBody2D


onready var playerDetectionZone = $DeteccionNPC
onready var bocadiloTexto = $Bocadillo
onready var bocadilloTexto2 = $Bocadillo2
onready var texto = $Bocadillo/RichTextLabel
onready var texto2 = $Bocadillo2/RichTextLabel
var state = IDLE
enum {
	IDLE, 
	TEXTO, 
}

# Called when the node enters the scene tree for the first time.
func _ready():
	state = IDLE

func _physics_process(delta):	
	match state:
		IDLE:
			seek_player()
		TEXTO:	
			var player = playerDetectionZone.player
			if player!= null:
				bocadiloTexto.visible= true
				texto.visible=true			
				if bocadilloTexto2!=null and texto2 !=null:
					bocadilloTexto2.visible = true
					texto2.visible=true
					
				
				texto.set_scroll_follow(true)
			else:
				bocadiloTexto.visible= false
				texto.visible = false				
				if bocadilloTexto2!=null and texto2 !=null:
					bocadilloTexto2.visible = false
					texto2.visible=false
				
				
				state = IDLE

func seek_player():
	if playerDetectionZone.can_see_player():
		state=TEXTO
	
