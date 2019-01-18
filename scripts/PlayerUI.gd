extends CanvasLayer

var life_bar = []

func _on_update_life():
    for idx in range(life_bar.size()):
        if idx <= Status.life - 1:
            life_bar[idx].frame = 0
        else:
            life_bar[idx].frame = 1

func _set_life_bar():
    $Life.position = Vector2(20, 20)
    life_bar.append($Life)

    for i in range(1, Constant.PLAYER_MAX_LIFE):
        var life = $Life.duplicate()
        life.position = $Life.position + Vector2(35, 0) * i
        add_child(life)
        life_bar.append(life)

func _set_score_position(window):
    $Score.margin_left = 5
    $Score.margin_top = window.y - 32
    $Score.margin_right = 128
    $Score.margin_bottom = window.y

func _ready():
    var window = get_viewport().get_visible_rect().size
    _set_score_position(window)
    _set_life_bar()
    $Score.text = 'Score: 0'

func _on_update_score():
    $Score.text = 'Score: %d' % Status.score
