inputs@{ nixpkgs, homeManager, ... }: configs:
    let makeSystem = { hostName, modules }:
        nixpkgs.lib.nixosSystem {
            specialArgs = { inherit hostName inputs; };
            inherit modules;
        };
    in builtins.foldl' (built: config:
        { "${config.hostName}" = makeSystem config; } // built
    ) {} configs
