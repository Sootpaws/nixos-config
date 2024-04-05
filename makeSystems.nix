{ nixpkgs, homeManager, ... }: configs:
    let makeSystem = { hostName, modules, primaryUser }:
        nixpkgs.lib.nixosSystem {
            specialArgs = {
                extraPkgs = { inherit homeManager; };
                settings = { inherit hostName primaryUser; };
            };
            inherit modules;
        };
    in builtins.foldl' (built: config:
        { "${config.hostName}" = makeSystem config; } // built
    ) {} configs
