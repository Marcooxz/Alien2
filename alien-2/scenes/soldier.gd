extends CharacterBody2D


const SPEED = 300.0
const RUNSPEED = 600.0
const JUMP_VELOCITY = -400.0
var facing := 1

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("izquierda", "derecha")
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("salto") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_pressed("izquierda") and Input.is_action_pressed("run") and is_on_floor():
		$AnimatedSprite2D.play("run")
		facing = -1
		$AnimatedSprite2D.position.x = 0
		$AnimatedSprite2D.position.y = 5
		$AnimatedSprite2D.scale.x = 1 * facing
		$AnimatedSprite2D.scale.y = 1
		
		$CollisionShape2D.scale.x= 1
		$CollisionShape2D.scale.y= 1
		$CollisionShape2D.position.x= 0
		$CollisionShape2D.position.y= 0
	else: if Input.is_action_pressed("izquierda") and is_on_floor():
		$AnimatedSprite2D.play("walking")
		facing = -1
		$AnimatedSprite2D.position.x = 0
		$AnimatedSprite2D.position.y = -5
		$AnimatedSprite2D.scale.x = 1 * facing
		$AnimatedSprite2D.scale.y = 1
		
		$CollisionShape2D.scale.x= 1
		$CollisionShape2D.scale.y= 1
		$CollisionShape2D.position.x= 0
		$CollisionShape2D.position.y= 0
	else: if Input.is_action_pressed("derecha") and Input.is_action_pressed("run") and is_on_floor():
		$AnimatedSprite2D.play("run")
		facing = 1
		$AnimatedSprite2D.position.x = 0
		$AnimatedSprite2D.position.y = 5
		
		$AnimatedSprite2D.scale.x = 1 * facing
		$AnimatedSprite2D.scale.y = 1
		
		$CollisionShape2D.scale.x= 1
		$CollisionShape2D.scale.y= 1
		$CollisionShape2D.position.x= 0
		$CollisionShape2D.position.y= 0
	else: if Input.is_action_pressed("derecha") and is_on_floor():
		$AnimatedSprite2D.play("walking")
		facing = 1
		
		$AnimatedSprite2D.position.x = 0
		$AnimatedSprite2D.position.y = -5
		
		$AnimatedSprite2D.scale.x = 1 * facing
		$AnimatedSprite2D.scale.y = 1
		
		$CollisionShape2D.scale.x= 1
		$CollisionShape2D.scale.y= 1
		$CollisionShape2D.position.x= 0
		$CollisionShape2D.position.y= 0
	else: if Input.is_action_pressed("attack1") and is_on_floor():
		$AnimatedSprite2D.play("shoot")
		
		$AnimatedSprite2D.position.x = 0
		$AnimatedSprite2D.position.y = 5
		$AnimatedSprite2D.scale.x = 1 * facing
		$AnimatedSprite2D.scale.y = 1
		
		$CollisionShape2D.scale.x= 1
		$CollisionShape2D.scale.y= 1
		$CollisionShape2D.position.x= 0
		$CollisionShape2D.position.y= 0
	else: if Input.is_action_pressed("reload") and is_on_floor() and direction == 0:
		$AnimatedSprite2D.play("reload")
		
		$AnimatedSprite2D.position.x = 3
		$AnimatedSprite2D.position.y = -11
		$AnimatedSprite2D.scale.x = 1.26 * facing
		$AnimatedSprite2D.scale.y = 1.26
		
		$CollisionShape2D.scale.x= 1
		$CollisionShape2D.scale.y= 1
		$CollisionShape2D.position.x= 0
		$CollisionShape2D.position.y= 0
	else: if Input.is_action_pressed("crouch") and is_on_floor():
		$AnimatedSprite2D.play("crouch-shoot")
		
		$AnimatedSprite2D.position.x = 0
		$AnimatedSprite2D.position.y = 10
		$AnimatedSprite2D.scale.x = 1 * facing
		$AnimatedSprite2D.scale.y = 1
		
		$CollisionShape2D.scale.x= 1
		$CollisionShape2D.scale.y= 0.5
		$CollisionShape2D.position.x= 0
		$CollisionShape2D.position.y= 25
	else: if is_on_floor(): 
		$AnimatedSprite2D.play("idle")
		
		$AnimatedSprite2D.position.x = 0
		$AnimatedSprite2D.position.y = 0
		$AnimatedSprite2D.scale.x = 1 * facing
		$AnimatedSprite2D.scale.y = 1
		
		$CollisionShape2D.scale.x= 1
		$CollisionShape2D.scale.y= 1
		$CollisionShape2D.position.x= 0
		$CollisionShape2D.position.y= 0

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if direction and Input.is_action_pressed("run"):
		velocity.x = direction * RUNSPEED
	else: if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
