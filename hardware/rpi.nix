# Hardware and basic system configuration for the RPi 3b+

{ ... }: {
    # Keep any system-level state compatible with this version
    system.stateVersion = "23.05";

    # This is an aarch64-linux system
    nixpkgs.hostPlatform = "aarch64-linux";

    # NixOS wants to enable GRUB by default
    boot.loader.grub.enable = false;

    # U-Boot setup
    boot.loader.generic-extlinux-compatible.enable = true;

    # This supposedly helps with "optimal runtime" on the Pi
    boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.kernelParams = ["cma=256M"];

    # Include the RPi GPU interface libraries
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
    boot.tmp.cleanOnBoot = true;

    # Use 1GB of additional swap memory in order to not run out of memory
    # when installing lots of things while running other things at the same time.
    swapDevices = [ { device = "/swapfile"; size = 1024; } ];
}
