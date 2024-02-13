theme: ''

# Sway configuration

# Terminal emulator command
set $term alacritty

#
# Keybindings
#

# Use the logo key as the primary modifier
set $mod Mod4

# Non-arrow direction keys
set $left j
set $right l
set $up i
set $down k

# Switch to open mode
bindsym $mod+o mode "open"
mode "open" {
    bindsym m exec dmenu_path | dmenu | xargs swaymsg exec --, mode "default"
    bindsym t exec $term, mode "default"
    bindsym w exec librewolf, mode "default"
    bindsym a exec tor-browser, mode "default"
    bindsym k exec keepassxc, mode "default"
    bindsym l exec libreoffice, mode "default"
    bindsym F4 exec $term --command $music_script select, mode "default"

    # Return to default mode
    bindsym Return mode "default"
    bindsym Escape mode "default"
}

# Kill focused window
bindsym $mod+Shift+q kill

# Reload configuration file
bindsym $mod+Shift+c reload

# Exit sway (logs you out of your Wayland session)
bindsym $mod+Shift+e exec swaynag -t warning -m 'Exit?' -B 'Yes' 'swaymsg exit'

# Lock screen
bindsym $mod+n exec $screen_lock

# Drag windows by holding down $mod and left mouse button.
# Resize them with right mouse button + $mod.
floating_modifier $mod normal

# You can "split" the current object of your focus with
# $mod+b or $mod+v, for horizontal and vertical splits
# respectively.
bindsym $mod+b splith
bindsym $mod+v splitv

# Switch the current container between different layout styles
bindsym $mod+s layout stacking
bindsym $mod+w layout tabbed
bindsym $mod+e layout toggle split

# Make the current focus fullscreen
bindsym $mod+f fullscreen

# Toggle the current focus between tiling and floating mode
bindsym $mod+Shift+space floating toggle

# Stick the focused window in place
bindsym $mod+p sticky toggle

# Swap focus between the tiling area and the floating area
bindsym $mod+space focus mode_toggle

# Move focus to the parent container
bindsym $mod+a focus parent

# Move focus using $mod+direction
bindsym $mod+$left focus left
bindsym $mod+$down focus down
bindsym $mod+$up focus up
bindsym $mod+$right focus right
bindsym $mod+Left focus left
bindsym $mod+Down focus down
bindsym $mod+Up focus up
bindsym $mod+Right focus right

# Move focused window using $mod+Shift+direction
bindsym $mod+Shift+$left move left
bindsym $mod+Shift+$down move down
bindsym $mod+Shift+$up move up
bindsym $mod+Shift+$right move right
bindsym $mod+Shift+Left move left
bindsym $mod+Shift+Down move down
bindsym $mod+Shift+Up move up
bindsym $mod+Shift+Right move right

# Switch to resize mode
bindsym $mod+r mode "resize"

set $resize_step 10px

mode "resize" {
    # left  - shrink width
    # right - grow   width
    # up    - shrink height
    # down  - grow   height
    bindsym $left resize shrink width $resize_step
    bindsym $down resize grow height $resize_step
    bindsym $up resize shrink height $resize_step
    bindsym $right resize grow width $resize_step
    bindsym Left resize shrink width $resize_step
    bindsym Down resize grow height $resize_step
    bindsym Up resize shrink height $resize_step
    bindsym Right resize grow width $resize_step

    # Return to default mode
    bindsym Return mode "default"
    bindsym Escape mode "default"
}

# Switch to workspace
bindsym $mod+1 workspace number 1
bindsym $mod+2 workspace number 2
bindsym $mod+3 workspace number 3
bindsym $mod+4 workspace number 4
bindsym $mod+5 workspace number 5
bindsym $mod+6 workspace number 6
bindsym $mod+7 workspace number 7
bindsym $mod+8 workspace number 8
bindsym $mod+9 workspace number 9
bindsym $mod+0 workspace number 10

# Move focused container to workspace
bindsym $mod+Shift+1 move container to workspace number 1
bindsym $mod+Shift+2 move container to workspace number 2
bindsym $mod+Shift+3 move container to workspace number 3
bindsym $mod+Shift+4 move container to workspace number 4
bindsym $mod+Shift+5 move container to workspace number 5
bindsym $mod+Shift+6 move container to workspace number 6
bindsym $mod+Shift+7 move container to workspace number 7
bindsym $mod+Shift+8 move container to workspace number 8
bindsym $mod+Shift+9 move container to workspace number 9
bindsym $mod+Shift+0 move container to workspace number 10

# Move the currently focused window to the scratchpad
bindsym $mod+Shift+minus move scratchpad

# Show the next scratchpad window or hide the focused scratchpad window.
# If there are multiple scratchpad windows, this command cycles through them.
bindsym $mod+minus scratchpad show

# Output control mode
bindsym $mod+m mode "monitor"
mode "monitor" {
    # Scaling control
    bindsym 1 output - scale 1
    bindsym 2 output - scale 1.1
    bindsym 3 output - scale 1.2
    bindsym 4 output - scale 1.3
    bindsym 5 output - scale 1.4
    bindsym 6 output - scale 1.5
    bindsym 7 output - scale 1.6
    bindsym 8 output - scale 1.7
    bindsym 9 output - scale 1.8
    bindsym 0 output - scale 1.9

    # Return to default mode
    bindsym Return mode "default"
    bindsym Escape mode "default"
}

# Audio control
bindsym --locked F1 exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
bindsym --locked F2 exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- -l 1.2
bindsym --locked F3 exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1.2
bindsym --locked Shift+F2 exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%- -l 1.2
bindsym --locked Shift+F3 exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+ -l 1.2

# Music control
set $music_script nu ~/.config/nushell/scripts/music.nu
bindsym --locked --release F4 exec $music_script pause
bindsym --locked F4+x exec $music_script stop
bindsym --locked F4+bracketright exec $music_script next
bindsym --locked F4+bracketleft exec $music_script prev

# Backlight control
bindsym --locked F6 exec brillo -U 5
bindsym --locked F7 exec brillo -A 5
bindsym --locked Shift+F6 exec brillo -U 1
bindsym --locked Shift+F7 exec brillo -A 1

# Screenshot
bindsym F10 exec shotman --capture region

# Passthrough
bindsym $mod+Shift+p mode "passthrough"
mode "passthrough" {
    bindsym $mod+Shift+p mode "default"
}

#
# Appearence
#

# Gaps
gaps inner 16px

# Disable title bars
default_border pixel

# Wallpaper
output * bg ~/.config/sway/wallpaper.jpg fill

# Font
font pango:${theme.font} 11

# Colors
client.focused \
    ${theme.colors.accent.strong} ${theme.colors.primary.strong} \
    ${theme.colors.secondary.weak} ${theme.colors.accent.strong} \
    ${theme.colors.accent.strong}
client.focused_inactive \
    ${theme.colors.accent.medium} ${theme.colors.primary.strong} \
    ${theme.colors.secondary.weak} ${theme.colors.accent.medium} \
    ${theme.colors.accent.medium}
client.unfocused \
    ${theme.colors.accent.weak} ${theme.colors.primary.strong} \
    ${theme.colors.secondary.weak} ${theme.colors.accent.weak} \
    ${theme.colors.accent.weak}
client.urgent \
    ${theme.colors.accent.extra} ${theme.colors.primary.strong} \
    ${theme.colors.secondary.weak} ${theme.colors.accent.extra} \
    ${theme.colors.accent.extra}

#
# Input configuration
#

input "type:keyboard" {
    repeat_delay 250
    repeat_rate 25
}

input "type:touchpad" {
    accel_profile adaptive
    dwt disabled
    tap enabled
    middle_emulation enabled
    drag disabled
}

#
# Status Bar
#

# Read `man 5 sway-bar` for more information about this section.
bar {
    font pango:${theme.font} 10
    position top
    status_command i3status-rs ~/.config/i3status-rust/config-default.toml
    colors {
        background ${theme.colors.primary.medium}
        statusline ${theme.colors.secondary.medium}
        binding_mode ${theme.colors.accent.strong} \
            ${theme.colors.primary.strong} \
            ${theme.colors.secondary.medium}

        focused_workspace ${theme.colors.accent.strong} \
            ${theme.colors.primary.strong} \
            ${theme.colors.secondary.medium}
        active_workspace ${theme.colors.accent.medium} \
            ${theme.colors.primary.medium} \
            ${theme.colors.secondary.medium}
        inactive_workspace ${theme.colors.accent.weak} \
            ${theme.colors.primary.weak} \
            ${theme.colors.secondary.medium}
        urgent_workspace ${theme.colors.accent.extra} \
            ${theme.colors.primary.weak} \
            ${theme.colors.secondary.medium}
    }
}

#
# Other
#

# Enable workspace toggling
workspace_auto_back_and_forth yes

# Screen lock command
set $screen_lock swaylock -f -c 000000

# Include default configuration
include /etc/sway/config.d/*

''
