# Configuration for the Nu shell

{ config, pkgs, ... }: {
    programs.nushell = {
        # Actually enable Nu
        enable = true;
        # Link the config file
        configFile = { source = ./config.nu; };
        # Link the environment file
        envFile = { source = ./env.nu; };

        shellAliases = {
            ll = "ls -l";
            la = "ls -a";
            lla = "ls -la";
        };
    };
}
