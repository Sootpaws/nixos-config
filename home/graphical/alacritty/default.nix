# Configuration for the Alacritty terminal emulator

{ settings, ... }: {
    programs.alacritty = {
        enable = true;

        settings = {
            # Functional
            shell = { program = "nu"; };
            # Visual
            window.opacity = 0.5;
            font = { family = settings.theme.font; };
            colors = {
                primary = {
                    foreground = settings.theme.colors.secondary.strong;
                    dim_foreground = settings.theme.colors.secondary.medium;
                    background = settings.theme.colors.primary.weak;
                };
            };
        };
    };
}
