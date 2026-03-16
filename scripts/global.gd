extends Node

func get_room_locations() -> Array[Node]:
	return get_tree().get_nodes_in_group("room_locations")

