extends RigidBody2D

signal screen_exited

var text setget set_text, get_text
var size setget ,get_size

func _physics_process(delta):
    var window = get_viewport().get_visible_rect().size
    if window.y < position.y + 30:
        emit_signal('screen_exited')
        queue_free()

func set_text(text):
    $Label.text = text

func get_text():
    return $Label.text

func get_size():
    return $CollisionShape2D.shape.extents

func dead():
    $AnimationPlayer.play('dead')
