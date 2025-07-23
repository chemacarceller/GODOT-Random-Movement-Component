class_name RandomMovementComponent extends Node

# Property indicating if the movement is applied to an Actor or a Component
# If the movement is applied to an Actor the local posiiton changes everyframe because is the global position
# If the movement is applied to a Component the local position doesn't change
@export var _isActorAttached : bool = true

# Property to activate or deactivate the movement
@export var _isEnabled : bool = true

func set_IsEnabled(value : bool) -> void :
	_isEnabled = value

func get_IsEnebled() -> bool :
	return _isEnabled

# Exported variables of the MovementComponent
## Sphere Radius for the vibration movement
@export_range(0.01, 0.1) var movementRadius : float = 0.05

# Internal variables
# Getting the ParentActor
@onready var _parentActor : Node3D = get_parent()

# Getting the ParentActor position
@onready var _parentActorPosition : Vector3 = _parentActor.position

# Flag indicating if the Offset should be calculated
# The idea is the ParentActor moves and comes back to its position in the next frame (odd versus even frames)
var _newOffset : bool = true

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		_parentActor = null


# the movement code
func _physics_process(_delta: float) -> void:
	
	# Only if it is enabled
	if _isEnabled and _parentActor != null:
		# Offset to move
		var offset : Vector3 = Vector3.ZERO

		if (_isActorAttached):
			_parentActorPosition = _parentActor.position

		# If we should calculate the offset to move
		if (_newOffset) :
			var rng = RandomNumberGenerator.new()
			offset = Vector3(rng.randf_range(-1.0, 1.0) * movementRadius, rng.randf_range(-1.0, 1.0) * movementRadius,rng.randf_range(-1.0, 1.0) * movementRadius)
			_parentActor.position = _parentActorPosition + offset
		else:
			_parentActor.position = _parentActorPosition - offset

		# Toogles the offset
		_newOffset = not _newOffset
