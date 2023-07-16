# Configuration for the Sway tiling Wayland compositor

{ config, pkgs, ... }: {
    # Link the Sway config file
    xdg.configFile.sway = {
        source = ./config;
        target = "sway/config";
    };
}
