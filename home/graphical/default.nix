# Home Manager configuration for graphical environments

{ pkgs, config, osConfig, ... }: {
    imports = [
        ../../programs/sway
        ../../programs/alacritty
        ../../programs/librewolf
    ];

    # Install-only packages
    home.packages = with pkgs; [
        (osConfig.theme.font.package pkgs)
        shotman
        pavucontrol
        tor-browser
        signal-desktop
        keepassxc
        libreoffice
        gimp
        krita
        inkscape
        (factorio-space-age.override (import ../../private.nix).factorio)
        prismlauncher
    ];

    wayland.windowManager.sway.customConfig.openKeybinds = {
        a = "tor-browser";
        s = "signal-desktop";
        k = "keepassxc";
        l = "libreoffice";
        f = "factorio";
        p = "prismlauncher";
    };
}
