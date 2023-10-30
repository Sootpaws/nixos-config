{ nixpkgs, homeManager, ... }: configs:
    let makeSystem = { hostName, hardware, profile, primaryUser, theme }:
        nixpkgs.lib.nixosSystem {
            specialArgs = {
                extraPkgs = { inherit homeManager; };
                settings = { inherit hostName primaryUser theme; };
            };
            modules = [ hardware profile ];
        };
    in builtins.foldl' (built: config:
        { "${config.hostName}" = makeSystem config; } // built
    ) {} configs
