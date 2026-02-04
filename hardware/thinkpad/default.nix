{ lib, inputs, ... }: {
    imports = [ inputs.disko.nixosModules.disko ./disk.nix ];

    # System state
    system.stateVersion = "25.11";
    home-manager.users.primary.home.stateVersion = "25.11";

    # Hardware
    nixpkgs.hostPlatform = "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = true;

    # Bootloader
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Kernel
    boot.initrd.availableKernelModules = [
        # Generated config
        "xhci_pci"
        "ahci"
        "usb_storage"
        "sd_mod"
        "rtsx_pci_sdmmc"
        # Needed for mounting the header drive
        "nls_cp437"
        "nls_iso8859_1"
        "vfat"
    ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-intel" ];
    boot.extraModulePackages = [ ];

    # Since preOpenCommands happens after waiting for the header to show up
    boot.initrd.preLVMCommands = lib.mkBefore "sleep 3; mount -vrm /dev/disk/by-label/KEYS /keys";
    boot.initrd.postDeviceCommands = "umount /keys; rmdir /keys";
}
