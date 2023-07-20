# Configuration for the Nu shell

{ config, pkgs, ... }: {
    programs.nushell = {
        # Actually enable Nu
        enable = true;
        # Link the config file
        configFile = { source = ./config.nu; };
    };
}
