extends Node

signal update_score # 得点更新のシグナル

const Alphabet = preload('res://scenes/Alphabet.tscn')
const GameOver = preload('res://scenes/GameOver.tscn')

var fall_speed = 1
var window

var alphabet_pattern = RegEx.new()
var alphabets = []

func _next_alphabet():
    return alphabets[randi() % 26]

func _on_target_screen_exited():
    Status.life -= 1
    if Status.life < 1:
        $PopTimer.stop()
        if Status.score > Status.high_score:
            Util.save()
        yield(get_tree().create_timer(2), 'timeout')
        add_child(GameOver.instance())

func _get_pop_position(obj):
    var x = randi() % int(window.x - obj.size.x / 2)
    if x < obj.size.x:
        x = obj.size.x / 2
    return Vector2(x, 0)

func _generate_target():
    var alphabet = Alphabet.instance()
    alphabet.position = _get_pop_position(alphabet)
    alphabet.text = _next_alphabet()
    alphabet.gravity_scale = fall_speed
    alphabet.connect('screen_exited', self, '_on_target_screen_exited')
    alphabet.connect('screen_exited', $PlayerUI, '_on_update_life')
    add_child(alphabet)

func _pop_alphabet():
    _generate_target()

func _is_match_alphabet(alphabet):
    for node in get_children():
        if not alphabet_pattern.search(node.name):
            continue
        if node.text == alphabet:
            Status.score += 1
            fall_speed = int(Status.score / Constant.SPEED_UP_COUNT) + 1
            emit_signal('update_score')
            node.dead()

func _unhandled_key_input(event):
    if event.pressed and not $PopTimer.is_stopped():
        var alphabet = char(event.scancode)
        _is_match_alphabet(alphabet)

func _ready():
    randomize()

    window = get_viewport().get_visible_rect().size

    Status.life = Constant.PLAYER_MAX_LIFE
    Status.score = 0

    $Background.margin_right = window.x
    $Background.margin_bottom = window.y

    alphabet_pattern.compile('Alphabet')

    for code in range(65, 91):
        alphabets.append(char(code))
