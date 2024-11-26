{ pkgs, config, ... }: let
    modifier = [ "Alt" ];
    # Use common windowing keybinds
    keybinds = import ../../common/windowing.nix { inherit modifier; };
    bindName = keys: "bind \"${ (toString keys) }\"";
    formatBinds = bindings: builtins.listToAttrs (map (binding: with binding; {
        name = bindName (map (key:
                if key == "Escape" then "Esc" else key
            ) keys);
        value = {
            moveFocus = { MoveFocus = action.direction; };
            moveWindow = { MovePane = action.direction; };
            moveFocusTab = { GoToTab = action.tab; };
            moveWindowTab = { }; # TODO
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
        enable = true;
        settings = {
            ui.pane_frames.hide_session_name = true;
            default_shell = config.home.sessionVariables.SHELL;
            keybinds = {
                _props = { clear-defaults = true; };
                normal = formatBinds keybinds.normal // {
                    ${bindName (modifier ++ [ "o" ])} = { NewPane = []; };
                    ${bindName (modifier ++ [ "t" ])} = { NewTab = []; };
                };
                resize = formatBinds keybinds.resize;
            };
        };
    };
}
