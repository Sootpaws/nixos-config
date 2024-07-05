# Configuration for the Sway tiling Wayland compositor

{ systemConfig, ... }: {
    imports = [ ./i3bar-rs.nix ];

    # Link the Sway config file
    xdg.configFile.swayConfig = {
        text = import ./config.nix systemConfig.theme;
        target = "sway/config";
    };

    # Link the wallpaper image
    xdg.configFile.swayWallpaper = {
        source = systemConfig.theme.wallpaper;
        target = "sway/wallpaper.jpg";
    };

    # Link the Nushell scripts for graphical environment
    programs.nushell.shellAliases = {
        music = "nu ~/.config/nushell/scripts/music.nu";
    };
}
