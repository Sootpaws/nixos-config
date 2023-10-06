
let run = $"exec alacritty --working-directory ($env.PWD) --command nix develop --command"

swaymsg splitv
swaymsg $"($run) bacon";
sleep 0ms
swaymsg move up
swaymsg focus down
swaymsg $"($run) gitui";
sleep 0ms
swaymsg $"($run) nu -c 'sleep 10ms; micro'";
sleep 0ms
swaymsg move left
sleep 0ms
nix develop --command nu -e clear
