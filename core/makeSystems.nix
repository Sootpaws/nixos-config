inputs@{ nixpkgs, ... }:
    builtins.mapAttrs (hostName: modules: nixpkgs.lib.nixosSystem {
        specialArgs = { inherit hostName inputs; };
        inherit modules;
    })
