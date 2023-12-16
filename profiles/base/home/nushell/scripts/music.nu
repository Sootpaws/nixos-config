let mpv_socket = "/tmp/mpv.socket";
let playlist_dir = $"($env.HOME)/Music/Playlists/"

def main [p] {
    if $p == "pause" {
        pause;
    } else if $p == "stop" {
        stop;
    } else if $p == "next" {
        next;
    } else if $p == "prev" {
        prev;
    } else if $p == "status" {
        status;
    } else if $p == "select" {
        play ( select_playlist );
    } else {
        play $p;
    }
    null
}

def pause [] {
    let paused = mpv_property "pause";
    let new_pause = { "true": "no", "false": "yes" } |
        get ($paused | into string);
    mpv_command [ "set_property" "pause" $new_pause ];
}

def stop [] { mpv_command [ "quit" ]; }
def next [] { mpv_command [ "playlist-next" "force" ]}
def prev [] { mpv_command [ "playlist-prev" ]}

def status [] {
    print ( if (ps | where name =~ "mpv") == [] {
        { text: "" }
    } else {
        let $song = mpv_property "media-title"
            | str replace ".mp3" "" | str replace --all "_" " ";
        let $paused = if (mpv_property "pause") { "music_pause" } else { "" };
        let $playlist_item = (mpv_property "playlist-playing-pos") + 1;
        let $playlist_count = mpv_property "playlist-count";
        let $playlist = mpv_property "path" | split row "/" | drop 1 | last;
        {
            icon: $paused
            text: $"($song) ($playlist_item)/($playlist_count) ($playlist)"
        };
    } | to json)
}

def select_playlist [] {
    let selected = ls $playlist_dir | get name | each {
        |it| $it | split row "/" | last
    } | str join "\n" | fzy | str trim;
    if $selected == "" { exit } else { $selected }
}

def play [p] {
    let playlist = $playlist_dir + $p;
    mpv $"--input-ipc-server=($mpv_socket)" --shuffle --vo=tct $playlist;
}

def mpv_command [c] {
    let args = $c | each { |it| '"' + $it + '"' };
    let data = $'{ "command": ($args) }' + "\n"
        | socat - $mpv_socket
        | split row "\n" | each { |it| $it | from json }
    if ($data | length) == 0 {
        print "No music playing"; exit
    } else { $data | first }
}

def mpv_property [n] {
    mpv_command [ "get_property" $n ] | get data
}
