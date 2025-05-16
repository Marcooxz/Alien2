extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var facing := 1

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("left", "right") 
	if not is_on_floor():
		velocity += get_gravity() * delta
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	else: if not is_on_floor():
		$AnimatedSprite2D.play("jump")
		
		$AnimatedSprite2D.position.x = 0
		$AnimatedSprite2D.position.y = -25
		$AnimatedSprite2D.scale.x= 2.3 * facing
		$AnimatedSprite2D.scale.y= 2.3
		
		$CollisionShape2D.scale.x= 1
		$CollisionShape2D.scale.y= 1
		$CollisionShape2D.position.x= 0
		$CollisionShape2D.position.y= 0
	else: if Input.is_action_pressed("roar"):
		$AnimatedSprite2D.play("roar")
		
		$AnimatedSprite2D.position.x = 0
		$AnimatedSprite2D.position.y = 0
		$AnimatedSprite2D.scale.x= 2 * facing
		$AnimatedSprite2D.scale.y= 2
		
		$CollisionShape2D.scale.x= 1
		$CollisionShape2D.scale.y= 1
		$CollisionShape2D.position.x= 0
		$CollisionShape2D.position.y= 0
	else: if Input.is_action_pressed("left"):
		facing = -1
		$AnimatedSprite2D.play("moving")
		
		$AnimatedSprite2D.position.x = 0
		$AnimatedSprite2D.position.y = -25
		$AnimatedSprite2D.scale.x= 2 * facing
		$AnimatedSprite2D.scale.y= 2
		
		$CollisionShape2D.scale.x= 1
		$CollisionShape2D.scale.y= 1
		$CollisionShape2D.position.x= 0
		$CollisionShape2D.position.y= 0
	else: if Input.is_action_pressed("right"):
		facing = 1
		$AnimatedSprite2D.play("moving") 
		
		$AnimatedSprite2D.position.x = 0
		$AnimatedSprite2D.position.y = -25
		$AnimatedSprite2D.scale.x= 2 * facing
		$AnimatedSprite2D.scale.y= 2
		
		$CollisionShape2D.scale.x= 1
		$CollisionShape2D.scale.y= 1
		$CollisionShape2D.position.x= 0
		$CollisionShape2D.position.y= 0
	else: if is_on_floor(): 
		$AnimatedSprite2D.play("idle")
		
		$AnimatedSprite2D.position.x = 0
		$AnimatedSprite2D.position.y = 25
		$AnimatedSprite2D.scale.x= 0.93 * facing * (-1)
		$AnimatedSprite2D.scale.y= 0.93
		
		$CollisionShape2D.scale.x= 1
		$CollisionShape2D.scale.y= 1
		$CollisionShape2D.position.x= 0
		$CollisionShape2D.position.y= 0
		
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
