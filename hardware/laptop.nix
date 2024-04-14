# Hardware and basic system configuration for my laptop

{ ... }: {
    # Keep any system-level state compatible with this version
    system.stateVersion = "23.05";

    # System architecture
    nixpkgs.hostPlatform = "x86_64-linux";

    # Hardware
    powerManagement.cpuFreqGovernor = "powersave";
    hardware.cpu.intel.updateMicrocode = true;
    hardware.enableRedistributableFirmware = true;

    # Bootloader
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Kernel
    boot.initrd.availableKernelModules = [
        "xhci_pci"
        "thunderbolt"
        "vmd"
        "nvme"
        "usb_storage"
        "sd_mod"
        "rtsx_pci_sdmmc"
    ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-intel" ];
    boot.extraModulePackages = [ ];

    # File systems
    fileSystems = {
        "/" = {
            device = "/dev/disk/by-uuid/b7c36a66-4328-4399-a553-18119503dc4d";
            fsType = "ext4";
        };
        "/boot" = {
            device = "/dev/disk/by-uuid/4D4B-8BB5";
            fsType = "vfat";
        };
    };

    boot.initrd.luks.devices."luks-f0d99b6b-6090-4961-9a90-c0cf498ba3d5".device
        = "/dev/disk/by-uuid/f0d99b6b-6090-4961-9a90-c0cf498ba3d5";

    swapDevices = [
        { device = "/dev/disk/by-uuid/5fc27595-2b93-4421-96f9-ca104ce5319e"; }
    ];

    # Setup keyfile
    boot.initrd.secrets = {
        "/crypto_keyfile.bin" = null;
    };

    # Enable swap on luks
    boot.initrd.luks.devices."luks-ed27c180-2add-4ffe-98d0-4a93d6c89013".device = "/dev/disk/by-uuid/ed27c180-2add-4ffe-98d0-4a93d6c89013";
    boot.initrd.luks.devices."luks-ed27c180-2add-4ffe-98d0-4a93d6c89013".keyFile = "/crypto_keyfile.bin";
}
