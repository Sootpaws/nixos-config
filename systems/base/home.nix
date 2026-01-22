# Home Manager configuration for the primary user

{ lib, osConfig, pkgs, settings, ... }: {
    imports = [
        ../../programs/zellij
        ../../programs/nushell
        ../../programs/starship
        ../../programs/direnv
        ../../programs/micro
        ../../programs/git
        ../../programs/gitui
        ../../programs/btop
    ];

    # Allow Home Manager to manage itself
    programs.home-manager.enable = true;

    # General info
    home.username = osConfig.primaryUserInfo.systemName;
    home.homeDirectory = "/home/" + osConfig.primaryUserInfo.systemName;

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
