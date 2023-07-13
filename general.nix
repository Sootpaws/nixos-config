# General system-level configuration

{ config, pkgs, lib, extra-pkgs, hostName, ... }: let primaryUser = "sootpaws"; in {
    # Keep any system-level state compatible with this version
    system.stateVersion = "23.05";

    # Enable flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Force users and groups to be consistant with this configuration
    users.mutableUsers = false;

    # Basic setup for main user
    users.users.primary = {
        isNormalUser = true;
        name = primaryUser;
        description = primaryUser;
        hashedPassword = (import ./private.nix).mainHashedPassword;
        extraGroups = [ "wheel" "networkmanager" ];
    };

    # Use Home Manager for user configuration
    imports = [
        extra-pkgs.home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.users.primary = import ./home.nix primaryUser;
        }
    ];

    # Basic packages for managing configuration
    environment.systemPackages = with pkgs; [
        git
        gnumake
    ];

    # Set MOTD to show on login
    # The motd.nix file is generated by the makefile just before
    # invoking nixos-rebuild, and immidiately cleaned up afterward
    users.motd = import ./motd.nix;

    # Configure networking
    networking = {
        inherit hostName;
        wireless = {
            enable = true;
            networks = (import ./private.nix).wireless;
            interfaces = [ "wlan0" ];
        };
    };
}
