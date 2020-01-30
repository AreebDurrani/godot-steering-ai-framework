# Calculates an acceleration that attempts to move the agent towards the center
# of mass of the agents in the area defined by the `GSTProximity`.
class_name GSTCohesion
extends GSTGroupBehavior


var _center_of_mass: Vector3


func _init(agent: GSTSteeringAgent, proximity: GSTProximity).(agent, proximity) -> void:
	pass


func _calculate_steering(acceleration: GSTTargetAcceleration) -> GSTTargetAcceleration:
	acceleration.set_zero()
	_center_of_mass = Vector3.ZERO
	var neighbor_count = proximity._find_neighbors(_callback)
	if neighbor_count > 0:
		_center_of_mass *= 1.0 / neighbor_count
		acceleration.linear = (_center_of_mass - agent.position).normalized() * agent.linear_acceleration_max
	return acceleration


# Callback for the proximity to call when finding neighbors. Adds `neighbor`'s position
# to the center of mass of the group.
# virtual
func _report_neighbor(neighbor: GSTSteeringAgent) -> bool:
	_center_of_mass += neighbor.position
	return true
