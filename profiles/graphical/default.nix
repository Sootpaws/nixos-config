# General system-level configuration for running a grapical environment

{ config, extraPkgs, settings, ... }: {
    # Use Home Manager for user configuration
    imports = [
        ../base
        extraPkgs.homeManager.nixosModules.home-manager {
            home-manager.extraSpecialArgs = {
                sysConfig = config;
                inherit settings;
            };
            home-manager.useGlobalPkgs = true;
            home-manager.users.primary = import ./home;
        }
    ];

    # Enable the Sway Wayland compositor
    programs.sway.enable = true;

    # Enable XWayland to allow running X11 programs
    programs.xwayland.enable = true;

    # Enable the Brillo backlight controller
    hardware.brillo.enable = true;

    # Enable VirtualBox
    virtualisation.virtualbox.host.enable = true;
    users.users.primary.extraGroups = [ "vboxusers" ];

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
