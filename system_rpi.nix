# Hardware and basic system configuration for the RPi 3b+

{ config, pkgs, lib, ... }: {
    # This is an aarch64-linux system
    nixpkgs.hostPlatform = "aarch64-linux";

    # NixOS wants to enable GRUB by default
    boot.loader.grub.enable = false;

    # If you have a Raspberry Pi 2 or 3, pick this:
    boot.kernelPackages = pkgs.linuxPackages_latest;

    # A bunch of boot parameters needed for optimal runtime on RPi 3b+
    boot.kernelParams = ["cma=256M"];
    boot.loader.raspberryPi.enable = true;
    boot.loader.raspberryPi.version = 3;
    boot.loader.raspberryPi.uboot.enable = true;
    boot.loader.raspberryPi.firmwareConfig = ''
        gpu_mem=256
    '';
    environment.systemPackages = [ pkgs.libraspberrypi ];

    # File systems configuration for using the installer's partition layout
    fileSystems = {
        "/" = {
            device = "/dev/disk/by-label/NIXOS_SD";
            fsType = "ext4";
        };
    };

    # Preserve space by sacrificing documentation and history
    documentation.nixos.enable = false;
    nix.gc.automatic = true;
    nix.gc.options = "--delete-older-than 30d";
    boot.tmp.cleanOnBoot = true;

    # Use 1GB of additional swap memory in order to not run out of memory
    # when installing lots of things while running other things at the same time.
    swapDevices = [ { device = "/swapfile"; size = 1024; } ];
}
