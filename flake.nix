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
            makeSystem = { hostName, hardware, profile, primaryUser, theme }:
                nixpkgs.lib.nixosSystem {
                    specialArgs = {
                        extraPkgs = { inherit homeManager; };
                        settings = { inherit hostName primaryUser theme; };
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
            profile = ./profiles/graphical.nix;
            primaryUser = "sootpaws";
            theme = import themes/sunset;
        } {
            hostName = "sootpaws-rpi-nixos";
            hardware = ./hardware/rpi.nix;
            profile = ./profiles/graphical.nix;
            primaryUser = "sootpaws";
            theme = import themes/sunset;
        }];
    };
}
