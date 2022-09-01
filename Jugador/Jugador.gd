extends KinematicBody2D #hereda de KinematicBody2D

#------------- MOVIMIENTO -----------

#export -> Nos permite modificar el valor de la variable desde la interfaz
#velocidad maxima
export var MAX_SPEED= 80
#Aceleracion
export var ACCELERATION = 500 #Basada en el frame
#Friccion
export var FRICTION =  500
#Roll
export var ROLL_SPEED = 125

#velocidad
var velocity = Vector2.ZERO
#roll
var roll_vector = Vector2.DOWN
#Estadisticas
var stats = PlayerStats

var is_dead = false

#
onready var spriteJugador = $SpriteJugador
onready var spriteMuerte = $SpriteMuerte


#Sonido
const PlayerHurtSound = preload("res://Jugador/PlayerHurtSound.tscn")

#-------------- ANIMACION ----------
#onready -> la variable no será creada hasta que el nodo esté listo
onready var animationPlayer = $"AnimationPlayer" #Con $ tenemos un acceso directo, de este modo animationPlayer es un acceso al nodo
#Acceso al arbol de animacion
onready var animationTree = $"AnimationTree"
onready var animationState = animationTree.get("parameters/playback")
#La animación solo estará activa cuando el juegue se inicie

onready var guanteHitbox = $HitboxPivot/HitboxGuante
onready var hurtbox = $Hurtbox



func _ready():	
	#stats.connect("no_health", self, "queue_free")	
	stats.health=6
	animationTree.active=true
	guanteHitbox.knockback_vector = roll_vector
	
		
	
 
#---- ATAQUE -----

#enum -> enumeracion, variables que no pueden cambiar, tipo constantes, pero automaticamente creadas con valores.
enum {
	MOVE,
	ROLL,
	ATTACK
}
var state = MOVE 


#Control del personaje
func _physics_process(delta):#delta 1/60
	#Match es bastante parecido a un switch en java pero con ciertas diferencias.
	#Si el state es igual a MOVE, hace  lo que hay dentro de move, y así con todos.
	
	if !is_dead:
		match state:
			MOVE:
				move_state(delta)
			ROLL:
				roll_state(delta)
			ATTACK:
				attack_state(delta)
		
	
	

#Movimiento
func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized() #Esto nos permite obtener una velocidad x,y igual a x o y al normalizar el vector.
	
	if input_vector != Vector2.ZERO:
		roll_vector = input_vector
		guanteHitbox.knockback_vector = input_vector
		animationTree.set("parameters/Idle/blend_position",input_vector) #BlendPosition para Idle
		animationTree.set("parameters/Run/blend_position",input_vector) #BlendPosition para animacion correr
		animationTree.set("parameters/Attack/blend_position",input_vector) #BlendPosition para animacion atacar
		animationTree.set("parameters/Roll/blend_position",input_vector) #BlendPosition para animacion roll
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta	)		
	else:		
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	move() 
	
	#Transicion para roll
	if Input.is_action_just_pressed("roll"):
		state = ROLL
	
	
	#Si pulsamos la tecla ataque nos llevará a la funcion attack_state
	if Input.is_action_just_pressed("attack"):
		state = ATTACK 

#Ataque
func attack_state(delta):	
	animationState.travel("Attack")
	  

#Metodo que es llamado cuando acaba la animacion de ataque
func attack_animation_finished():
	state = MOVE  
	
#Final de animacion de giro
func roll_animation_finished():	
	velocity = velocity * 0.8
	state = MOVE
	

func roll_state(delta):
	velocity = roll_vector * ROLL_SPEED #Queremos que cuando hagamos un giro sea mas rapido que andar.
	animationState.travel("Roll")
	move()

#Función para la velocidad a la que llamaremos desde Roll 
func move():
	velocity = move_and_slide(velocity)


#Cuando el jugador es herido
func _on_Hurtbox_area_entered(area):
	if !is_dead:
		stats.health -=1  
		hurtbox.start_invincibility(0.5)
		hurtbox.create_hit_effect()
		#Sonido. Nos asegur
		var playerHurtSound = PlayerHurtSound.instance()
		get_tree().current_scene.add_child(playerHurtSound)
		
		if stats.health == 0:	
			muerte()

func muerte():
	is_dead = true
	spriteJugador.visible=false
	spriteMuerte.visible=true
	$Timer.start()	
	$MusicaMundo.stop()
	$MusicaGameOver.play()
	get_tree()
	
	print("has muerto")
	
	
	


func _on_Timer_timeout():
	get_tree().change_scene("res://PantallaTitulo.tscn")
