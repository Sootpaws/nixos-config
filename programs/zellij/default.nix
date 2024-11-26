{ pkgs, ... }: let
    # Use common windowing keybinds on Alt
    keybinds = import ../../common/windowing.nix { modifier = [ "Alt" ]; };
    formatBinds = bindings: builtins.listToAttrs (map (binding: with binding; {
        name = "bind \"${ toString (map (key:
                if key == "Escape" then "Esc" else key
            ) keys) }\"";
        value = {
            moveFocus = { MoveFocus = action.direction; };
            moveWindow = { MovePane = action.direction; };
            moveFocusTab = { GoToTab = action.tab; };
            moveWindowTab = { }; # TODO
            fullscreen = { ToggleFocusFullscreen = []; };
            killFocused = { CloseTab = []; };
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
            keybinds = {
                _props = { clear-defaults = true; };
                normal = formatBinds keybinds.normal;
                resize = formatBinds keybinds.resize;
            };
        };
    };
}
