{ nixpkgs, homeManager, ... }: configs:
    let makeSystem = { hostName, modules }:
        nixpkgs.lib.nixosSystem {
            specialArgs = {
                extraPkgs = { inherit homeManager; };
                settings = { inherit hostName; };
            };
            inherit modules;
        };
    in builtins.foldl' (built: config:
        { "${config.hostName}" = makeSystem config; } // built
    ) {} configs
