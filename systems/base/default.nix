# General system-level configuration

{ lib, config, pkgs, inputs, hostName, ... }: {
    options = {
        homeManagerModules = lib.mkOption {
            type = lib.types.listOf lib.types.path;
            default = [];
        };
        loginCommand = lib.mkOption {
            type = lib.types.str;
        };
    };

    imports = [
        # Use Home Manager for user configuration
        inputs.home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.users.primary.imports = builtins.concatLists
                [[ ./home.nix ] config.homeManagerModules];
        }
        ../../core/unfreeList.nix
        ../../core/theme.nix
        ../../core/primaryUserInfo.nix
    ];

    config = {
        # Enable flakes
        nix.settings.experimental-features = [ "nix-command" "flakes" ];

        # Disable channels, use the version of nixpkgs  the system was built
        # with instead
        nix.channel.enable = false;
        nix.registry.nixpkgs.flake = inputs.nixpkgs;
        nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

        # Enable automatic nix store cleaning
        nix.gc = {
            automatic = true;
            dates = "weekly";
            options = "--delete-older-than 30d";
        };

        # Enable automatic nix store optimization
        nix.optimise.automatic = true;

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
            extraGroups = [ "wheel" "networkmanager" "video" "docker" ];
            openssh.authorizedKeys.keys = config.primaryUserInfo.sshKeys;
        };

        # Configure networking
        networking = {
            inherit hostName;
            networkmanager.enable = true;
        };

        # Time zone
        services.automatic-timezoned.enable = true;

        # Sudo
        security.sudo = {
            execWheelOnly = true;
            extraConfig = "Defaults pwfeedback";
        };

        # Podman
        virtualisation.podman = {
            enable = true;
            dockerCompat = true;
            defaultNetwork.settings.dns_enabled = true;
        };

        # Firmware updates
        services.fwupd.enable = true;

        # Tailscale
        services.tailscale = {
            enable = true;
            useRoutingFeatures = "client";
        };

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
