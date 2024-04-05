# Configuration for the Nu shell

{ ... }: {
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
        };
    };

    # Link the scripts folder
    xdg.configFile.nushellScripts = {
        source = ./scripts;
        target = "nushell/scripts";
    };
}
