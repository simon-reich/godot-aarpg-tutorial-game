extends Node

const PLAYER = preload("uid://cky5nhr0in6hq") 
const INVENTORY_DATA: InventoryData = preload("res://gui/pause_menu/inventory/player_inventory.tres")

var player: Player
var player_spawned: bool = false

func _ready() -> void:
	add_player_instance()
	await get_tree().create_timer(0.2).timeout
	player_spawned = true

func add_player_instance() -> void:
	player = PLAYER.instantiate()
	add_child(player)

func set_player_health(max_hp: int, hp: int) -> void:
	player.max_hp = max_hp
	player.hp = hp

func set_player_postion(new_pos: Vector2) -> void:
	player.global_position = new_pos
	print("new pos ", new_pos)

func set_as_parent(_p: Node2D) -> void:
	if player.get_parent():
		player.get_parent().remove_child(player)
	_p.add_child(player)

func unparent_player(_p: Node2D) -> void:
	_p.remove_child(player)
