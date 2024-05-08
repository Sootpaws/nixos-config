# General system-level configuration for running a grapical environment

{ config, lib, pkgs, extraPkgs, ... }: {
    # Use Home Manager for user configuration
    imports = [
        ../base
        extraPkgs.homeManager.nixosModules.home-manager {
            home-manager.extraSpecialArgs = {
                sysConfig = config;
            };
            home-manager.useGlobalPkgs = true;
            home-manager.users.primary = import ../../home/graphical;
        }
    ];

    # Enable the Sway Wayland compositor
    programs.sway.enable = true;

    # Use greetd for login
    services.greetd = {
        enable = true;
        settings = rec {
            initial_session = {
                command = "${pkgs.sway}/bin/sway";
                user = config.primaryUserInfo.systemName;
            };
            default_session = initial_session;
        };
    };

    # Enable XWayland to allow running X11 programs
    programs.xwayland.enable = true;

    # Enable the Brillo backlight controller
    hardware.brillo.enable = true;

    # Enable VirtualBox
    virtualisation.virtualbox.host.enable = true;
    users.users.primary.extraGroups = [ "vboxusers" ];

    # Allow some specific unfree packages
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "factorio-alpha"
    ];

    # Configure audio
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
    };
}
