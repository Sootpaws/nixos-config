# Configuration for the Nu shell

{ config, pkgs, ... }: {
    programs.nushell = {
        # Actually enable Nu
        enable = true;
        # Link the config file
        configFile = { source = ./config.nu; };
    };
    # Link the environment file
    xdg.configFile.nushell_env = {
        source = ./env.nu;
        target = "nushell/env.nu";
    };
}
