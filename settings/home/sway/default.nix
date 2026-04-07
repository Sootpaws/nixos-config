{ osConfig, pkgs, lib, config, ... }: let
    enable = config.wayland.windowManager.sway.enable;
in {
    imports = [ ./i3bar-rs.nix ];

    # Open-mode bindings
    options.wayland.windowManager.sway.customConfig.openKeybinds =
        lib.mkOption { type = lib.types.attrsOf lib.types.str; };

    # Other programs used in default config
    config.home.packages = if enable then with pkgs; [ dmenu-rs wlrctl ] else [];

    # Main sway config
    config.wayland.windowManager.sway = let
        resize_step = "10px";
        theme = osConfig.theme;
        # Use common windowing keybinds
        modifier = [ config.wayland.windowManager.sway.config.modifier ];
        keybinds = import ../../../common/windowing.nix { inherit modifier; };
        bindName = keys: lib.strings.concatMapStringsSep "+" toString keys;
        formatBinds = bindings: builtins.listToAttrs (map (binding: with binding; {
            name = bindName keys;
            value = {
                moveFocus = "focus ${ lib.strings.toLower action.direction }";
                moveWindow = "move ${ lib.strings.toLower action.direction }";
                moveFocusTab = "workspace number ${ toString action.tab }";
                moveWindowTab = "move container to workspace number ${ toString action.tab }";
                fullscreen = "fullscreen";
                killFocused = "kill";
                mode = "mode \"${
                    if action.mode == "normal" then "default" else action.mode
                }\"";
                resize = "resize ${ action.direction } ${ action.axis } ${ resize_step }";
            }.${action.type};
        }) bindings);
    in {
        customConfig.openKeybinds = {
            m = "dmenu_path | dmenu | xargs swaymsg exec --";
            n = "echo nixpkgs#`echo nixpkgs | dmenu` | xargs swaymsg exec -- nix run";
        };
        config = {
            modifier = "Mod4";

            keybindings = formatBinds keybinds.normal // {
                ${ bindName (modifier ++ [ "Shift" "c" ]) } = "reload";
                ${ bindName (modifier ++ [ "Shift" "e" ]) } =
                    "exec swaynag -t warning -m 'Exit?' -B 'Yes' 'swaymsg exit'";
                ${ bindName (modifier ++ [ "n" ]) } = "exec swaylock -f -c 000000";
                ${ bindName (modifier ++ [ "space" ]) } = "focus mode_toggle";
                ${ bindName (modifier ++ [ "Shift" "space" ]) } = "floating toggle";
                ${ bindName [ "F1" ] } =
                    "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
                ${ bindName [ "F2" ] } =
                    "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- -l 1.2";
                ${ bindName [ "F3" ] } =
                    "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1.2";
                ${ bindName [ "Shift" "F2" ] } =
                    "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%- -l 1.2";
                ${ bindName [ "Shift" "F3" ] } =
                "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+ -l 1.2";
                ${ bindName [ "F4" ] } = "exec mpc toggle";
                ${ bindName [ "F6" ] } = "exec brillo -U 5";
                ${ bindName [ "F7" ] } = "exec brillo -A 5";
                ${ bindName [ "Shift" "F6" ] } = "exec brillo -U 1";
                ${ bindName [ "Shift" "F7" ] } = "exec brillo -A 1";
                ${ bindName [ "F10" ] } =
                    "exec \"XDG_SCREENSHOTS_DIR=~/Pictures/Screenshots shotman --capture region\"";
                ${ bindName (modifier ++ [ "o" ]) } = "mode \"open\"";
                ${ bindName (modifier ++ [ "d" ]) } = "mode \"display\"";
                ${ bindName (modifier ++ [ "m" ]) } = "mode \"mouse\"";
                ${ bindName (modifier ++ [ "p" ]) } = "mode \"passthrough\"";
            };
            modes = {
                resize = formatBinds keybinds.resize;
                open = builtins.mapAttrs
                    (_: run: "exec ${ run }, mode \"default\"")
                    config.wayland.windowManager.sway.customConfig.openKeybinds
                    // { Escape = "mode \"default\""; };
                display = builtins.listToAttrs (builtins.genList (i: {
                    name = toString i;
                    value = "output - scale 1.${ toString i }";
                }) 10) // { Escape = "mode \"default\""; };
                mouse = let
                    ofs = [
                        { mod = []; ofs = 20; }
                        { mod = [ "Shift" ]; ofs = 1; }
                    ];
                    dirs = builtins.concatMap ({ mod, ofs }: [
                        { binding = mod ++ [ "Up" ]; dx = 0; dy = -ofs; }
                        { binding = mod ++ [ "Down" ]; dx = 0; dy = ofs; }
                        { binding = mod ++ [ "Left" ]; dx = -ofs; dy = 0; }
                        { binding = mod ++ [ "Right" ]; dx = ofs; dy = 0; }
                    ]) ofs;
                    moveBinds = map ({ binding, dx, dy }: {
                        name = bindName binding;
                        value = "exec wlrctl pointer move ${ toString dx } ${ toString dy }";
                    }) dirs;
                    scrollBinds = map ({ binding, dx, dy }: {
                        name = bindName (map (k: {
                            "Up" = "w";
                            "Down" = "s";
                            "Left" = "a";
                            "Right" = "d";
                            "Shift" = "Shift";
                        }.${k}) binding);
                        value = "exec wlrctl pointer scroll ${ toString dy } ${ toString dx }";
                    }) dirs;
                in builtins.listToAttrs moveBinds //
                    builtins.listToAttrs scrollBinds //
                {
                    Return = "exec wlrctl pointer click";
                    Escape = "mode \"default\"";
                };
                passthrough = {
                    ${ bindName (modifier ++ [ "p" ]) } = "mode \"default\"";
                };
            };

            fonts = {
                names = [ theme.font.name ];
                size = 11.0;
            };
            window.titlebar = false;
            floating.titlebar = false;
            focus.wrapping = "yes";
            workspaceAutoBackAndForth = true;
            colors = builtins.listToAttrs (map
                ({ name, color}: with theme.colors; {
                    inherit name;
                    value = {
                        border = color;
                        background = primary.strong;
                        text = secondary.weak;
                        indicator = color;
                        childBorder = color;
                    };
                }) (with theme.colors.accent; [
                    { name = "focused"; color = strong; }
                    { name = "focusedInactive"; color = medium; }
                    { name = "unfocused"; color = weak; }
                    { name = "urgent"; color = extra; }
                ]));
            bars = [{
                fonts = {
                    names = [ theme.font.name ];
                    size = 10.0;
                };
                position = "top";
                trayOutput = "none";
                statusCommand = "i3status-rs ~/.config/i3status-rust/config-default.toml";
                colors = with theme.colors; {
                    background = primary.medium;
                    statusline = secondary.medium;
                    bindingMode = {
                        border = accent.strong;
                        background = primary.strong;
                        text = secondary.medium;
                    };
                    focusedWorkspace = {
                        border = accent.strong;
                        background = primary.strong;
                        text = secondary.medium;
                    };
                    activeWorkspace = {
                        border = accent.medium;
                        background = primary.medium;
                        text = secondary.medium;
                    };
                    inactiveWorkspace = {
                        border = accent.weak;
                        background = primary.weak;
                        text = secondary.medium;
                    };
                    urgentWorkspace = {
                        border = accent.extra;
                        background = primary.weak;
                        text = secondary.medium;
                    };
                };
            }];
            gaps.inner = 16;
            input = {
                "type:keyboard" = {
                    repeat_delay = "250";
                    repeat_rate = "25";
                    xkb_options = "compose:ralt";
                };
                "type:touchpad" = {
                    accel_profile = "adaptive";
                    dwt = "disabled";
                    tap = "enabled";
                    middle_emulation = "enabled";
                    drag = "disabled";
                };
            };
            output."*".bg = let
                bgPath = osConfig.theme.wallpaper;
                bgName = builtins.baseNameOf bgPath;
                drv = pkgs.stdenv.mkDerivation {
                    name = "swaybg";
                    src = bgPath;
                    dontUnpack = true;
                    installPhase = "mkdir $out; cp $src $out/${bgName}";
                };
            in "${drv}/${bgName} fill";
        };
    };

    # Set up screen sharing
    config.xdg.portal = {
        inherit enable;
        extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
        config.common.default = "*";
    };

    # Configure swaylock
    config.programs.swaylock = {
        inherit enable;
    };
}
