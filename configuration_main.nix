# 

{ config, pkgs, lib, home-manager, ... }: {
    # Keep any system-level state compatible with this version
    system.stateVersion = "23.05";

    # Enable flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Force users and groups to be consistant with this configuration
    users.mutableUsers = false;

    # Basic setup for main user
    users.users.sootpaws = {
        isNormalUser = true;
        description = "sootpaws";
        password = "no";
        extraGroups = [ "wheel" "networkmanager" ];
    };

    # Use Home Manager for user configuration
    imports = [
        home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.users.sootpaws = import ./home.nix;
        }
    ];

    # Basic packages for managing configuration
    environment.systemPackages = with pkgs; [
        git
        gnumake
    ];

    # Set MOTD to show on login
    users.motd = "TODO: Put something useful here";

    # Configure networking
    networking = {
        hostName = "sootpaws-rpi-nixos";
        wireless = {
            enable = true;
            networks = (import ./private.nix).wireless;
            interfaces = [ "wlan0" ];
        };
    };
}
