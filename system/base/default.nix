# General system-level configuration

{ lib, config, pkgs, extraPkgs, hostName, ... }: {
    options = {
        homeManagerModules = lib.mkOption {
            type = lib.types.listOf lib.types.path;
            default = [];
        };
        loginCommand = lib.mkOption {
            type = lib.types.str;
        };
    };

    # Use Home Manager for user configuration
    imports = [
        extraPkgs.homeManager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.users.primary.imports = builtins.concatLists
                [[ ../../home/base ] config.homeManagerModules];
        }
    ];

    config = {
        # Enable flakes
        nix.settings.experimental-features = [ "nix-command" "flakes" ];

        # Enable automatic nix store cleaning
        nix.gc.automatic = true;
        nix.gc.dates = "weekly";
        nix.gc.options = "--delete-older-than 30d";

        # Use greetd for login
        services.greetd = {
            enable = true;
            settings = rec {
                initial_session = {
                    command = config.loginCommand;
                    user = config.primaryUserInfo.systemName;
                };
                default_session = initial_session;
            };
        };

        # Force users and groups to be consistant with this configuration
        users.mutableUsers = false;

        # Basic setup for main user
        users.users.primary = {
            isNormalUser = true;
            name = config.primaryUserInfo.systemName;
            description = config.primaryUserInfo.systemName;
            hashedPassword = (import ../../private.nix).mainHashedPassword;
            extraGroups = [ "wheel" "networkmanager" "video" ];
        };

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
        services.automatic-timezoned.enable = true;

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
    };
}
