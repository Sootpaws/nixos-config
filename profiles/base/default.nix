# General system-level configuration

{ config, pkgs, lib, extraPkgs, settings, ... }: {
    # Keep any system-level state compatible with this version
    system.stateVersion = "23.05";

    # Enable flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Enable automatic nix store cleaning
    nix.gc.automatic = true;
    nix.gc.dates = "weekly";
    nix.gc.options = "--delete-older-than 30d";

    # Force users and groups to be consistant with this configuration
    users.mutableUsers = false;

    # Basic setup for main user
    users.users.primary = {
        isNormalUser = true;
        name = settings.primaryUser.systemName;
        description = settings.primaryUser.systemName;
        hashedPassword = (import ../../private.nix).mainHashedPassword;
        extraGroups = [ "wheel" "networkmanager" "video" ];
    };

    # Use Home Manager for user configuration
    imports = [
        extraPkgs.homeManager.nixosModules.home-manager {
            home-manager.extraSpecialArgs = {
                inherit settings;
            };
            home-manager.useGlobalPkgs = true;
            home-manager.users.primary = import ./home;
        }
    ];

    # Basic packages for managing configuration
    environment.systemPackages = with pkgs; [
        git
        gnumake
    ];

    # Use greetd for login
    services.greetd = {
        enable = true;
        settings = rec {
            initial_session = {
                command = "${pkgs.sway}/bin/sway";
                user = settings.primaryUser.systemName;
            };
            default_session = initial_session;
        };
    };

    # Configure networking
    networking = {
        inherit (settings) hostName;
        networkmanager.enable = true;
    };

    # Time zone
    time.timeZone = "America/New_York";

    # Internationalisation
    i18n = let locale = "en_US.UTF-8"; in {
        defaultLocale = locale;
        extraLocaleSettings = {
            LC_ADDRESS = locale;
            LC_IDENTIFICATION = locale;
            LC_MEASUREMENT = locale;
            LC_MONETARY = locale;
            LC_NAME = locale;
            LC_NUMERIC = locale;
            LC_PAPER = locale;
            LC_TELEPHONE = locale;
            LC_TIME = locale;
        };
    };
}
