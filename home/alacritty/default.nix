# Configuration for the Alacritty terminal emulator

{ theme, ... }: {
    programs.alacritty = {
        enable = true;

        settings = {
            # Functional
            shell = { program = "nu"; };
            # Visual
            window.opacity = 0.5;
            font = { family = theme.font; };
            colors = {
                primary = {
                    foreground = theme.colors.secondary.strong;
                    dim_foreground = theme.colors.secondary.medium;
                    background = theme.colors.primary.weak;
                };
            };
        };
    };
}
