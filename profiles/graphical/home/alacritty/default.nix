# Configuration for the Alacritty terminal emulator

{ sysConfig, ... }: {
    programs.alacritty = {
        enable = true;

        settings = {
            # Functional
            shell = { program = "nu"; };
            # Visual
            window.opacity = 0.5;
            font = { normal = { family = sysConfig.theme.font; }; };
            colors = {
                primary = {
                    foreground = sysConfig.theme.colors.secondary.strong;
                    dim_foreground = sysConfig.theme.colors.secondary.medium;
                    background = sysConfig.theme.colors.primary.weak;
                };
            };
        };
    };
}
