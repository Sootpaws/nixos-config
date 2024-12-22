# Home Manager configuration for graphical environments

{ pkgs, config, osConfig, ... }: {
    imports = [
        ../../programs/sway
        ../../programs/alacritty
    ];

    # Install-only packages
    home.packages = with pkgs; [
        (osConfig.theme.font.package pkgs)
        shotman
        pavucontrol
        librewolf
        tor-browser-bundle-bin
        keepassxc
        gimp
        krita
        libreoffice
        (factorio-space-age.override (import ../../private.nix).factorio)
        inkscape
    ];
}
