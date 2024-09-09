# Configuration for the Sway tiling Wayland compositor

{ osConfig, ... }: {
    imports = [ ./i3bar-rs.nix ];

    # Link the Sway config file
    xdg.configFile.swayConfig = {
        text = import ./config.nix osConfig.theme;
        target = "sway/config";
    };

    # Link the wallpaper image
    xdg.configFile.swayWallpaper = {
        source = osConfig.theme.wallpaper;
        target = "sway/wallpaper.jpg";
    };
}
