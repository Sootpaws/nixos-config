{
    description = "NixOS configuration for sootpaws-*-nixos";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        homeManager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs@{ nixpkgs, homeManager, ... }: let
        makeSystems = configs: let
            makeSystem = { hostName, hardware, profile, theme }:
                nixpkgs.lib.nixosSystem {
                    specialArgs = {
                        extraPkgs = { inherit homeManager; };
                        settings = { inherit hostName theme; };
                    };
                    modules = [ hardware profile ];
                };
        in builtins.foldl' (built: config:
            { "${config.hostName}" = makeSystem config; } // built
        ) {} configs;
    in {
        nixosConfigurations = makeSystems [{
            hostName = "sootpaws-laptop-nixos";
            hardware = ./hardware/laptop.nix;
            profile = ./general.nix;
            theme = import themes/sunset;
        } {
            hostName = "sootpaws-rpi-nixos";
            hardware = ./hardware/rpi.nix;
            profile = ./general.nix;
            theme = import themes/sunset;
        }];
    };
}

