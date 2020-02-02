extends Reference

class_name Requirement

enum RequirementType {SCREWS = 9, DISPLAY = 10, FIRE = 11, CLEANING = 12, EMPTY = -1}

var requirement_index : int = RequirementType.EMPTY setget set_requirement_index
var requirement_satisfied: bool = false setget set_requirement_satisfied

func set_requirement_index(var req_index : int) -> void :
	print("set_requirement_index: %d" % req_index)
	requirement_index = req_index

func set_requirement_satisfied(var req_satisfied : bool) -> void :
	print("set_requirement_satisfied: %s" % req_satisfied)
	requirement_satisfied = req_satisfied
