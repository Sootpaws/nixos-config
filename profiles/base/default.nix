# General system-level configuration

{ config, pkgs, extraPkgs, hostName, ... }: {
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
        name = config.primaryUser.systemName;
        description = config.primaryUser.systemName;
        hashedPassword = (import ../../private.nix).mainHashedPassword;
        extraGroups = [ "wheel" "networkmanager" "video" ];
    };

    # Use Home Manager for user configuration
    imports = [
        extraPkgs.homeManager.nixosModules.home-manager {
            home-manager.extraSpecialArgs = {
                systemConfig = config;
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

    # Configure networking
    networking = {
        inherit hostName;
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
