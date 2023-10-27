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

            nixdev = "nix develop --command nu";
            nixsh = "nix-shell --command nu";
            dev = "nu ~/.config/nushell/scripts/dev.nu";
            music = "nu ~/.config/nushell/scripts/music.nu";
        };
    };

    # Link the scripts folder
    xdg.configFile.nushellScripts = {
        source = ./scripts;
        target = "nushell/scripts";
    };
}
