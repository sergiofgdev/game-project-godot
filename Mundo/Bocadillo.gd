extends Sprite

var mydialog ["Esto es una prueba"]
var dialogepage = 0
onready var RichText = get_node("Bocadillo/RichTextLabel")



# Called when the node enters the scene tree for the first time.
func _ready():
	RichText.set_bbcode(myDialog[dialogepage])
	RichText.set_visible_characteres[0]


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
