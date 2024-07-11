# General system-level configuration for running a grapical environment

{ config, lib, pkgs, ... }: {
    imports = [
        ../base
    ];

    # Add additional Home Manager modules
    homeManagerModules = [ ../../home/graphical ];

    # Enable the Sway Wayland compositor
    programs.sway.enable = true;
    loginCommand = "sway";

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
