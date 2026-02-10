# Home Manager configuration for the primary user

{ lib, osConfig, pkgs, settings, ... }: {
    imports = [
        ../../programs/btop
        ../../programs/direnv
        ../../programs/git
        ../../programs/micro
        ../../programs/nushell
        ../../programs/starship
        ../../programs/zellij
    ];

    # General info
    home.username = osConfig.primaryUserInfo.systemName;
    home.homeDirectory = "/home/" + osConfig.primaryUserInfo.systemName;

    # Preconfigured packages
    programs = {
        btop.enable = true;
        direnv.enable = true;
        git.enable = true;
        gitui.enable = true;
        micro.enable = true;
        nushell.enable = true;
        starship.enable = true;
        zellij.enable = true;
    };

    # Install-only packages
    home.packages = with pkgs; [
        bacon
        zip
        unzip
        wget
        socat
        openvpn
    ];
}
