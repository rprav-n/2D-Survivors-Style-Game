class_name WeightedTable

var items: Array[Dictionary] = []
var weight_sum: int = 0


func add_item(item: PackedScene, weight: int):
	items.append({"item": item, "weight": weight})
	weight_sum += weight

func pick_item() -> PackedScene:
	var choosen_weight: int = randi_range(1, weight_sum)
	var iteration_sum: int = 0
	for item in items:
		iteration_sum += item["weight"]
		if choosen_weight <= iteration_sum:
			return item["item"]
	
	return null
