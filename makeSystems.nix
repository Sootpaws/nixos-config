{ nixpkgs, homeManager, ... }: configs:
    let makeSystem = { hostName, modules, primaryUser, theme }:
        nixpkgs.lib.nixosSystem {
            specialArgs = {
                extraPkgs = { inherit homeManager; };
                settings = { inherit hostName primaryUser theme; };
            };
            inherit modules;
        };
    in builtins.foldl' (built: config:
        { "${config.hostName}" = makeSystem config; } // built
    ) {} configs
