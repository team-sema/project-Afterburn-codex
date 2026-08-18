# Give the component a class name so it can be instanced as a custom node
class_name StatsComponent
extends Node

# Create the health variable and connect a setter
@export var health: int = 1:
	set(value):
		var previous_health := health
		health = value
		
		# Signal out that the health has changed
		health_changed.emit()
		
		# health_changed listeners may recover health (NearDeathExperienceComponent).
		# Emit death only for a completed alive -> dead transition.
		if previous_health > 0 and health <= 0:
			no_health.emit()

# Create our signals for health
signal health_changed() # Emit when the health value has changed
signal no_health() # Emit when there is no health left
