# Home Manager configuration for the primary user

{ lib, config, pkgs, settings, primaryUser, ... }: {
    imports = [
        ./sway
        ./alacritty
        ./nushell
        ./starship
        ./micro
        ./git
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
    home.packages = with pkgs; [
        nerdfonts
        shotman
        pavucontrol
        nodejs_20
        bacon
        du-dust
        comma
        neofetch
        librewolf
        tor-browser-bundle-bin
        helm
    ];

    # mpv, media player
    programs.mpv = {
        enable = true;
    };

    # GitUI, TUI Git interface
    programs.gitui = {
        enable = true;
    };
}
