class_name Plant extends Node2D

@onready var hit_box: HitBox = $HitBox

func _ready() -> void:
	hit_box.damaged.connect(_take_damage)
	
func _take_damage(hurt_box: HurtBox) -> void:
	queue_free()
