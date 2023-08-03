# Home Manager configuration for the primary user

{ lib, config, pkgs, settings, primaryUser, ... }: {
    imports = [
        ./sway
        ./alacritty
        ./nushell
        ./starship
        ./micro
        ./git
        ./librewolf
    ];

    # Keep stateful data compatible with this version
    home.stateVersion = "23.05";
    # Allow Home Manager to manage itself
    programs.home-manager.enable = true;

    # General info
    home.username = primaryUser;
    home.homeDirectory = "/home/" + primaryUser;

    # Have Home Manager manage XDG directories
    xdg.enable = true;

    # Enable fontconfig
    fonts.fontconfig.enable = true;

    # Install-only packages
    home.packages = [
        pkgs.nerdfonts
        pkgs.du-dust
        pkgs.neofetch
    ];
}
