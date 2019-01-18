extends Node

func _get_save_data():
    return {
        'high_score': Status.score
    }

func save():
    var file = File.new()
    file.open(Constant.SAVE_FILE, File.WRITE)
    file.store_line(to_json(_get_save_data()))
    file.close()

func load_data():
    var file = File.new()
    if not file.file_exists(Constant.SAVE_FILE):
        return

    file.open(Constant.SAVE_FILE, File.READ)
    while not file.eof_reached():
        var current_line = parse_json(file.get_line())

        if not current_line:
            break

        for key in current_line.keys():
            if key == 'high_score' and current_line.high_score:
                Status.high_score = current_line.high_score

    file.close()
