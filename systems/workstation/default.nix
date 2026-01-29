# General system-level configuration for running a grapical environment

{ config, lib, pkgs, ... }: {
    imports = [
        ../base
    ];

    # Add additional Home Manager modules
    homeManagerModules = [ ./home.nix ];

    # Start Sway on login
    loginCommand = "sway";

    # Bluetooth
    hardware.bluetooth.enable = true;

    # Enable the Brillo backlight controller
    hardware.brillo.enable = true;

    # Enable VirtualBox
    virtualisation.virtualbox.host.enable = true;
    users.users.primary.extraGroups = [ "vboxusers" ];

    # Make PAM and Swaylock cooperate
    security.pam.services.swaylock = {};

    # Allow some specific unfree packages
    allowedUnfree = [ "factorio-space-age" ];

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
