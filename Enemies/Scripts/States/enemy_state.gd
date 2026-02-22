class_name EnemyState extends Node

# Stores a refence to the enemy that this state belongs to
var enemy: Enemy
var state_machine: EnemyStateMachine


func _init() -> void:
	pass

func enter() -> void:
	enemy.update_animation("idle")
	pass

func exit() -> void:
	pass

func process(_delta: float) -> EnemyState:
	return null

func physics(_delta: float) ->EnemyState:
	return null
