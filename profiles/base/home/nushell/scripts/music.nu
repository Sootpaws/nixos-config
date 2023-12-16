let mpv_socket = "/tmp/mpv.socket";

def main [p] {
    if $p == "pause" {
        pause;
    } else {
        let playlist = $"($env.HOME)/Music/Playlists/($p)";
        mpv $"--input-ipc-server=($mpv_socket)" --shuffle --vo=tct $playlist;
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
    let data = $'{ "command": ($args) }' + "\n"
        | socat - $mpv_socket
        | split row "\n" | each { |it| $it | from json }
    if ($data | length) == 0 { null } else { $data | first }
}
