def main [p] {
    if $p == "pause" {
        pause;
    } else {
        let playlist = $"($env.HOME)/Music/Playlists/($p)";
        mpv --input-ipc-server=/tmp/mpv.socket --shuffle --vo=tct $playlist;
    }
}

def pause [] {
    let data = mpv_command [ "get_property" "pause" ];
    if $data == null {
        print "No music playing";
    } else {
        let paused = $data | get data;
        let new_pause = { "true": "no", "false": "yes" } |
            get ($paused | into string);
        mpv_command [ "set_property" "pause" $new_pause ];
    };
    null
}

def mpv_command [c] {
    let args = $c | each { |it| '"' + $it + '"' };
    $'{ "command": ($args) }' + "\n" | socat - /tmp/mpv.socket | from json
}
