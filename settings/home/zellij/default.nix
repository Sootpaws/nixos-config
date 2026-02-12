{ pkgs, lib, config, ... }: {
    options = {
        programs.zellij.config.modifier = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            default = [ "Super" "Ctrl" ];
        };
    };
    config = let
        modifier = config.programs.zellij.config.modifier;
        # Use common windowing keybinds
        keybinds = import ../../../common/windowing.nix { inherit modifier; };
        bindName = keys: "bind \"${ toString keys }\"";
        formatBinds = bindings: builtins.listToAttrs (map (binding: with binding; {
            name = bindName (map (key:
                    if key == "Escape" then "Esc" else key
                ) keys);
            value = {
                moveFocus = { MoveFocus = action.direction; };
                moveWindow = { MovePane = action.direction; };
                moveFocusTab = { GoToTab = action.tab; };
                moveWindowTab = { GoToTab = action.tab; }; # TODO
                fullscreen = { ToggleFocusFullscreen = []; };
                killFocused = { CloseFocus = []; };
                mode = { SwitchToMode = action.mode; };
                resize = { Resize = {
                    "grow width" = "Right";
                    "grow height" = "Down";
                    "shrink width" = "Left";
                    "shrink height" = "Up";
                }.${action.direction + " " + action.axis}; };
            }.${action.type};
        }) bindings);
    in {
        programs.zellij = {
            settings = {
                ui.pane_frames.hide_session_name = true;
                session_serialization = false;
                show_startup_tips = false;
                keybinds = {
                    _props = { clear-defaults = true; };
                    normal = formatBinds keybinds.normal // {
                        ${bindName (modifier ++ [ "o" ])} = { NewPane = []; };
                        ${bindName (modifier ++ [ "p" ])} = { NewPane = "Right"; };
                        ${bindName (modifier ++ [ "l" ])} = { NewPane = "Down"; };
                        ${bindName (modifier ++ [ "t" ])} = { NewTab = []; };
                    };
                    resize = formatBinds keybinds.resize;
                };
            };
        };
        xdg.configFile.zellijLayouts = {
            enable = config.programs.zellij.enable;
            source = ./layouts;
            recursive = true;
            target = "zellij/layouts";
        };
    };
}
