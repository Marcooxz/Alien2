extends CharacterBody2D


const SPEED = 300.0
const RUNSPEED = 600.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("salto") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if Input.is_action_pressed("izquierda") and Input.is_action_pressed("run") and is_on_floor():
		$AnimatedSprite2D.play("run")
		$AnimatedSprite2D.scale.x = -1
		$CollisionShape2D.scale.y= 1
		$CollisionShape2D.position.y= -5
	else: if Input.is_action_pressed("izquierda") and is_on_floor():
		$AnimatedSprite2D.play("walk")
		$AnimatedSprite2D.scale.x = -1
		$CollisionShape2D.scale.y= 1
		$CollisionShape2D.position.y= -5
	else: if Input.is_action_pressed("derecha") and Input.is_action_pressed("run") and is_on_floor():
		$AnimatedSprite2D.play("run")
		$AnimatedSprite2D.scale.x = 1
		$CollisionShape2D.scale.y= 1
		$CollisionShape2D.position.y= -5
	else: if Input.is_action_pressed("derecha") and is_on_floor():
		$AnimatedSprite2D.play("walk")
		$AnimatedSprite2D.scale.x = 1
		$CollisionShape2D.scale.y= 1
		$CollisionShape2D.position.y= -5
	else: if Input.is_action_pressed("attack1") and is_on_floor():
		$AnimatedSprite2D.play("fire_standing")
		$CollisionShape2D.scale.y= 1
		$CollisionShape2D.position.y= -5
	else: if Input.is_action_pressed("crouch") and is_on_floor():
		$AnimatedSprite2D.play("fire_kneel")
		$CollisionShape2D.scale.y= 0.5
		$CollisionShape2D.position.y= 15
	else: if is_on_floor(): 
		$AnimatedSprite2D.play("idle")
		$CollisionShape2D.scale.y= 1
		$CollisionShape2D.position.y= -5
	
	var direction := Input.get_axis("izquierda", "derecha")
	
	if direction and Input.is_action_pressed("run"):
		velocity.x = direction * RUNSPEED
	else: if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
