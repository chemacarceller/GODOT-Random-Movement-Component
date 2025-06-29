class_name RandomMovementComponent extends Node

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
@onready var _parentActorPosition : Vector3 = _parentActor.global_position

# Flag indicating if the Offset should be calculated
# The idea is the ParentActor moves and comes back to its position in the next frame (odd versus even frames)
var _newOffset : bool = true
var _offset : Vector3 = Vector3.ZERO

# the movement code
func _physics_process(_delta: float) -> void:
	
	# Only if it is enabled
	if _isEnabled :

		_parentActorPosition = _parentActor.global_position

		# If we should calculate the offset to move
		if (_newOffset) :
			var rng = RandomNumberGenerator.new()
			_offset = Vector3(rng.randf_range(-1.0, 1.0) * movementRadius, rng.randf_range(-1.0, 1.0) * movementRadius,rng.randf_range(-1.0, 1.0) * movementRadius)
			_parentActor.global_position = _parentActorPosition + _offset
		else:
			_parentActor.global_position = _parentActorPosition - _offset

		# Toogles the offset
		_newOffset = not _newOffset
