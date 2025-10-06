{ osConfig, ... }: {
    wayland.windowManager.sway.customConfig.openKeybinds.t = "alacritty";
    programs.alacritty = {
        enable = true;
        settings = {
            terminal.shell = "zellij";
            window.opacity = 0.5;
            font = { normal = { family = osConfig.theme.font.name; }; };
            colors = {
                primary = {
                    foreground = osConfig.theme.colors.secondary.strong;
                    dim_foreground = osConfig.theme.colors.secondary.medium;
                    background = osConfig.theme.colors.primary.weak;
                };
            };
        };
    };
}
