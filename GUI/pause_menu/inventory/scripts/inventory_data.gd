class_name InventoryData extends Resource

@export var slots: Array[SlotData]


func _init() -> void:
	connect_slots()

func add_item(item: ItemData, count: int = 1) -> bool:
	for slot in slots:
		if slot and slot.item_data == item:
			slot.quantity += count
			return true
	
	for i in slots.size():
		if slots[i] == null:
			var new = SlotData.new()
			new.item_data = item
			new.quantity = count
			slots[i] = new
			new.changed.connect(slot_changed)
			return true
			
	print("inventory was full!")
	return false

func connect_slots() -> void:
	for slot in slots:
		if slot:
			slot.changed.connect(slot_changed)

func slot_changed() -> void:
	for slot in slots:
		if slot:
			if slot.quantity < 1:
				slot.changed.connect(slot_changed)
				var index = slots.find(slot)
				slots[index] = null
				emit_changed()


func get_save_data() -> Array:
	var items_to_save: Array = []
	for i in slots.size():
		items_to_save.append(item_to_dict((slots[i])))
	return items_to_save
	

func item_to_dict(slot: SlotData) -> Dictionary:
	var result = {item = "", quantity = 0}
	if slot != null:
		result.quantity = slot.quantity
		if slot.item_data != null:
			result.item = slot.item_data.resource_path
	return result


func parse_save_data( save_data: Array) -> void:
	var array_size = slots.size()
	slots.clear()
	slots.resize(array_size)
	for i in save_data.size():
		slots[i] = item_from_dict((save_data[i]))
		connect_slots()


func item_from_dict(save_object: Dictionary) -> SlotData:
	if save_object.item == "":
		return null
	var new_slot: SlotData = SlotData.new()
	new_slot.item_data = load(save_object.item)
	new_slot.quantity = int(save_object.quantity)
	return new_slot
