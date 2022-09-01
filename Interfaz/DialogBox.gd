extends Control


var dialog=[
	"¿Una pandemia?, ¿ahora?, tiene que ser una broma.",
	"Y los inutiles de los politicos diciendome que me quede en casa.",
	"JAA!!",
	"No quieren aceptar el hecho de que soy un hombre que es experto en la lucha de guerrillas... ",
	"excepcional con armas de fuego, con el cuchillo, con mis propias manos...",
	"soy un hombre que esta entrenado para ignorar el dolor, las condiciones climatologicas...",
	"vivir de lo que da la tierra, comer cosas que harian vomitar a una cabra...",
	"pero...",
	"¿VIRUSSSS??",
	"En fin, vere que puedo hacer, a ver si encuentro a mis amigos...",
	"y por el camino matare a tantos condenados virus como pueda."
]

var dialog_index=0
var finished = false

func _ready():
	load_dialog()
	
	
func _process(delta):
	$"dialog_box_boton".visible = finished
	if Input.is_action_just_pressed("ui_accept"):
		load_dialog()

func load_dialog():
	if dialog_index< dialog.size():
		finished=false
		$RichTextLabel.bbcode_text = dialog[dialog_index]
		$RichTextLabel.percent_visible = 0
		$Tween.interpolate_property(
			$RichTextLabel, "percent_visible",0,1,1,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
		$Tween.start()
	else:
		queue_free()
	dialog_index +=1
	


func _on_Tween_tween_completed(object, key):
	finished = true
