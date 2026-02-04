{
    disko.devices = {
        disk.main = {
            type = "disk";
            device = "/dev/sda"; # This seems consistent enough
            content = {
                type = "gpt";
                partitions = {
                    # Boot partition
                    ESP = {
                        size = "512M";
                        type = "EF00";
                        content = {
                            type = "filesystem";
                            format = "vfat";
                            mountpoint = "/boot";
                            mountOptions = [ "umask=0077" ];
                        };
                    };
                    # BTRFS-on-LUKS persistent partition
                    luks = {
                        size = "100%";
                        content = let
                            headerPath = "/keys/sootpaws-server-nixos.lhd";
                            extraArgs = [ "--header ${headerPath}" ];
                        in {
                            type = "luks";
                            name = "crypted";
                            extraFormatArgs = extraArgs;
                            extraOpenArgs = extraArgs;
                            settings = {
                                bypassWorkqueues = true;
                                header = headerPath;
                            };
                            content = {
                                type = "btrfs";
                                extraArgs = [ "-f" ]; # Force overwrite of existing FS
                                subvolumes = {
                                    nix = {
                                        mountpoint = "/nix";
                                        mountOptions = [ "compress=zstd" "noatime" ];
                                    };
                                    swap = {
                                        mountpoint = "/swap";
                                        swap.swapfile.size = "8G";
                                    };
                                };
                            };
                        };
                    };
                };
            };
        };
        # Ephemeral root
        nodev.root = {
            mountpoint = "/";
            fsType = "tmpfs";
            mountOptions = [ "defaults" "size=2G" "mode=755" ];
        };
    };
}
