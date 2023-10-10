# General system-level configuration for running a grapical environment

{ config, pkgs, lib, extraPkgs, settings, ... }: let primaryUser = "sootpaws"; in {
    # Use Home Manager for user configuration
    imports = [
        ./base.nix
        extraPkgs.homeManager.nixosModules.home-manager {
            home-manager.extraSpecialArgs = {
                inherit settings primaryUser;
            };
            home-manager.useGlobalPkgs = true;
            home-manager.users.primary = import ./home/graphical;
        }
    ];

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
}
