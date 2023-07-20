# Configuration for the Sway tiling Wayland compositor

{ config, pkgs, theme, ... }: {
    # Link the Sway config file
    xdg.configFile.swayConfig = {
        text = import ./config.nix theme;
        target = "sway/config";
    };

    # Link the wallpaper image
    xdg.configFile.swayWallpaper = {
        source = theme.wallpaper;
        target = "sway/wallpaper.jpg";
    };
}
