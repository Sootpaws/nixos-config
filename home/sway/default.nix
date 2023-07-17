# Configuration for the Sway tiling Wayland compositor

{ config, pkgs, ... }: {
    # Link the Sway config file
    xdg.configFile.sway_config = {
        source = ./config;
        target = "sway/config";
    };

    # Link the wallpaper image
    xdg.configFile.sway_wallpaper = {
        source = ./wallpaper.jpg;
        target = "sway/wallpaper.jpg";
    };
}
