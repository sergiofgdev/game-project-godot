extends KinematicBody2D

const  EnemyDeathEffect = preload("res://Efectos/EfectoVirusMuerte.tscn")

export  var ACCELERATION = 300 #Aceleracion
export var MAX_SPEED = 50
export var FRICTION = 200
export var WANDER_TARGET_RANGE = 4

#Conducta del enemigo
enum {
	IDLE, #Se queda quieto
	WANDER, #Se mueve por ahi
	CHASE #Te persigue
}

var velocity = Vector2.ZERO
var knockback = Vector2.ZERO #Variable para el retroceso
var state = IDLE

#Acceso a las estadisticas del virus
onready var stats  = $Estadisticas
#Acceso a la deteccion del jugador
onready var playerDetectionZone = $DeteccionJugador
onready var sprite = $VirusAnimado

onready var hurtbox = $Hurtbox
onready var softCollision = $SoftCollision

onready var wander_controller = $WanderController



func _ready():
	state = pick_random_state([IDLE,WANDER])

#funcion de fisicas
func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO,200*delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, 200*delta)
			seek_player()
			
			if wander_controller.get_time_left() == 0:
				update_wander()
		WANDER:
			if wander_controller.get_time_left() == 0:
				update_wander()
							
			#Moverse a la positiontarget
			accelerate_towards_point(wander_controller.target_position,delta)
						
			if global_position.distance_to(wander_controller.target_position)<= WANDER_TARGET_RANGE:
				update_wander()
				
		CHASE:
			var player = playerDetectionZone.player 
			if player!= null:			
				
				accelerate_towards_point(player.global_position,delta)
			else:
				state = IDLE
				
	if softCollision.is_collading():
		velocity += softCollision.get_push_vector()*delta*400
	velocity = move_and_slide(velocity)



func accelerate_towards_point(point,delta):
	var direction = global_position.direction_to(point)
	velocity=velocity.move_toward(direction * MAX_SPEED, ACCELERATION* delta)
	#sprite.flip_h = velocity.x<0

func update_wander():
	state = pick_random_state([IDLE, WANDER])
	wander_controller.start_wander_timer(rand_range(1,3))

func seek_player():
	if playerDetectionZone.can_see_player():
		state=CHASE
	


func _on_Hurtbox_area_entered(area):	
	stats.health -= area.damage  #Cuando recibe un golpe se reduce la salud del virus en 1
	knockback = area.knockback_vector * 120
	hurtbox.create_hit_effect() 


#Cuando se queda sin puntos de vida muere
func _on_Estadisticas_no_health():
	queue_free()
	var enemyDeathEffect = EnemyDeathEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position
	
	


func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()
