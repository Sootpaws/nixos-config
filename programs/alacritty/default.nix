# Configuration for the Alacritty terminal emulator

{ systemConfig, ... }: {
    programs.alacritty = {
        enable = true;

        settings = {
            # Functional
            shell = { program = "nu"; };
            # Visual
            window.opacity = 0.5;
            font = { normal = { family = systemConfig.theme.font; }; };
            colors = {
                primary = {
                    foreground = systemConfig.theme.colors.secondary.strong;
                    dim_foreground = systemConfig.theme.colors.secondary.medium;
                    background = systemConfig.theme.colors.primary.weak;
                };
            };
        };
    };
}
