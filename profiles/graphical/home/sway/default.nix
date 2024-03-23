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

    # Link the Nushell scripts for graphical environment
    programs.nushell.shellAliases = {
        dev = "nu ~/.config/nushell/scripts/dev.nu";
        music = "nu ~/.config/nushell/scripts/music.nu";
    };
}
