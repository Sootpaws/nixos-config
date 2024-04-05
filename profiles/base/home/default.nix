# Home Manager configuration for the primary user

{ lib, sysConfig, pkgs, settings, ... }: {
    imports = [
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
    home.username = sysConfig.primaryUser.systemName;
    home.homeDirectory = "/home/" + sysConfig.primaryUser.systemName;

    # Have Home Manager manage XDG directories
    xdg.enable = true;

    # Enable fontconfig
    fonts.fontconfig.enable = true;

    # Install-only packages
    home.packages = with pkgs; [
        bacon
        du-dust
        comma
        zip
        unzip
        wget
        socat
        fzy
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
