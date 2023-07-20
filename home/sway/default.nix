# Configuration for the Sway tiling Wayland compositor

{ config, pkgs, ... }: {
    # Link the Sway config file
    xdg.configFile.swayConfig = {
        text = import ./config.nix;
        target = "sway/config";
    };

    # Link the wallpaper image
    xdg.configFile.swayWallpaper = {
        source = ./wallpaper.jpg;
        target = "sway/wallpaper.jpg";
    };
}
