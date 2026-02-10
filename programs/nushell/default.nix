{ ... }: {
    programs.nushell = {
        configFile = { source = ./config.nu; };
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
