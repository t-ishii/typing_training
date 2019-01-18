extends Node

func _ready():
    yield(get_tree().create_timer(2), 'timeout')
    var error = get_tree().change_scene('res://scenes/Title.tscn')
    if error:
        print('Error: ', error)
