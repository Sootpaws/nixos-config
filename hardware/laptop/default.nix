# Hardware and basic system configuration for my laptop

{ ... }: {
    system.stateVersion = "24.05";
    home-manager.users.primary.home.stateVersion = "26.05";

    # System architecture
    nixpkgs.hostPlatform = "x86_64-linux";

    # Hardware
    powerManagement.cpuFreqGovernor = "powersave";
    hardware.cpu.intel.updateMicrocode = true;
    hardware.enableRedistributableFirmware = true;
    services.thermald.enable = true;
    hardware.nvidia = {
        open = true;
        prime = {
            intelBusId = "PCI:0:2:0";
            nvidiaBusId = "PCI:1:0:0";
            offload = {
                enable = true;
                enableOffloadCmd = true;
            };
        };
    };
    services.xserver.videoDrivers = [ "nvidia" ];
    allowedUnfree = [ "nvidia-x11" "nvidia-settings" ];

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
            device = "/dev/disk/by-uuid/39b9dbde-ece8-4b50-b768-93ed7b09ff13";
            fsType = "ext4";
        };
        "/boot" = {
            device = "/dev/disk/by-uuid/41BA-73F8";
            fsType = "vfat";
            options = [ "fmask=0022" "dmask=0022" ];
        };
    };

    boot.initrd.luks.devices."luks-26f925e6-7942-4e9a-a440-9a483bedf325".device
        = "/dev/disk/by-uuid/26f925e6-7942-4e9a-a440-9a483bedf325";
    boot.initrd.luks.devices."luks-758de6ab-e41d-4285-b655-dbac5d5e4b84".device
        = "/dev/disk/by-uuid/758de6ab-e41d-4285-b655-dbac5d5e4b84";

    swapDevices = [
        { device = "/dev/disk/by-uuid/eba66b4b-37eb-4d03-ac00-18fda6ebb9c5"; }
    ];
}
