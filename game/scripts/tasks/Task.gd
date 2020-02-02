extends Reference

class_name Task

var device : Device = null
var requirements : Array = [] # of type Requirement
var waitingTime: int = 0
var startedAt: int = 0
var reward: int = 0
var taskCompleted: bool = false
var taskStarted: bool = false
var taskFailed: bool = false 

func get_current_requirement() -> Requirement :
	for i in range(requirements.size()):
		if !requirements[i].requirement_satisfied:
			return requirements[i]
	return null

