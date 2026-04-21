extends Node

func seconds_to_hours_minutes(seconds: float) -> String:
	var total_seconds = int(seconds)
	var hours = total_seconds / 3600
	var minutes = (total_seconds % 3600) / 60
	
	return "%dh %dm" % [hours, minutes]
