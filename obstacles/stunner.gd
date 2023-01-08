extends Area2D



func _on_Stunner_body_entered(body: Node) -> void:
	if not (body is Player):
		return

	body.stun()
