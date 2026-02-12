{ ... }: {
    programs.nushell = {
        # TODO: Config in nix
        configFile = { source = ./config.nu; };
        # TODO: Fix this mess
        envFile = { source = ./env.nu; };

        shellAliases = {
            ll = "ls -l";
            la = "ls -a";
            lla = "ls -la";
            mpt = "mpv --vo=tct";

            nixdev = "nix develop --command nu";
            nixsh = "nix-shell --command nu";

            dev = "zellij --layout dev";
            devrs = "zellij --layout devrs";
        };
    };
}
