{ nixpkgs, homeManager, ... }: configs:
    let makeSystem = { hostName, modules }:
        nixpkgs.lib.nixosSystem {
            specialArgs = {
                inherit hostName;
                extraPkgs = { inherit homeManager nixpkgs; };
            };
            inherit modules;
        };
    in builtins.foldl' (built: config:
        { "${config.hostName}" = makeSystem config; } // built
    ) {} configs
