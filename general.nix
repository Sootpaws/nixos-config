# General system-level configuration

{ config, pkgs, lib, extraPkgs, settings, ... }: let primaryUser = "sootpaws"; in {
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
        name = primaryUser;
        description = primaryUser;
        hashedPassword = (import ./private.nix).mainHashedPassword;
        extraGroups = [ "wheel" "networkmanager" "video" ];
    };

    # Use Home Manager for user configuration
    imports = [
        extraPkgs.homeManager.nixosModules.home-manager {
            home-manager.extraSpecialArgs = {
                inherit settings primaryUser;
            };
            home-manager.useGlobalPkgs = true;
            home-manager.users.primary = import ./home/graphical;
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

    # Enable the Sway Wayland compositor
    programs.sway.enable = true;

    # Enable XWayland to allow running X11 programs
    programs.xwayland.enable = true;

    # Enable the Brillo backlight controller
    hardware.brillo.enable = true;

    # Configure audio
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
    };

    # Configure networking
    networking = {
        inherit (settings) hostName;
        networkmanager.enable = true;
    };

    # Time zone
    time.timeZone = "America/New_York";

    # Internationalisation
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
    };
}
