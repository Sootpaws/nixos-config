# Configuration for the Alacritty terminal emulator

{ osConfig, ... }: {
    programs.alacritty = {
        enable = true;

        settings = {
            # Functional
            terminal.shell = "zellij";
            # Visual
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
