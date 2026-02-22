class_name Plant extends Node2D


func _ready() -> void:
	$HitBox.damaged.connect(_take_damage)
	

func _take_damage(hurt_box: HurtBox) -> void:
	queue_free()
