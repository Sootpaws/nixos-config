# Configuration for the Sway tiling Wayland compositor

{ osConfig, pkgs, ... }: {
    imports = [ ./i3bar-rs.nix ];

    # Install dmenu for opening programs without dedicated keybinds
    home.packages = with pkgs; [ dmenu-rs ];

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
