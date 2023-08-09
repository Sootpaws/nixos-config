# Configuration for the Sway tiling Wayland compositor

{ settings, ... }: {
    imports = [ ./i3bar-rs.nix ];

    # Link the Sway config file
    xdg.configFile.swayConfig = {
        text = import ./config.nix settings.theme;
        target = "sway/config";
    };

    # Link the wallpaper image
    xdg.configFile.swayWallpaper = {
        source = settings.theme.wallpaper;
        target = "sway/wallpaper.jpg";
    };
}
