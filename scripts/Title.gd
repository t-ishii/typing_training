extends CanvasLayer

func _ready():
    Util.load_data()

    var window = get_viewport().get_visible_rect().size

    $Background.margin_right = window.x
    $Background.margin_bottom = window.y

    $HighScore.text = 'HighScore: %d' % Status.high_score


func _on_StartButton_pressed():
    var error = get_tree().change_scene('res://scenes/Main.tscn')
    if error:
        print('Error: ', error)
