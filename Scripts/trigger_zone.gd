extends Area2D

enum ZoneType {NONE, WINZONE}

@export var zoneType : ZoneType


func _on_body_entered(body: Node2D) -> void:
	match zoneType:
		ZoneType.WINZONE:
			print("win")
