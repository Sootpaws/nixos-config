
swaymsg splitv
swaymsg $"exec alacritty --working-directory ($env.PWD) --command bacon";
sleep 0ms
swaymsg move up
swaymsg focus down
swaymsg $"exec alacritty --working-directory ($env.PWD) --command gitui";
sleep 0ms
swaymsg $"exec alacritty --working-directory ($env.PWD) --command nu -c 'sleep 10ms; micro'";
sleep 0ms
swaymsg move left
sleep 0ms
clear
