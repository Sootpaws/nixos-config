{
    description = "NixOS configuration for sootpaws-*-nixos";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        homeManager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs@{ nixpkgs, homeManager, ... }: {
        nixosConfigurations = {
            "sootpaws-laptop-nixos" = nixpkgs.lib.nixosSystem {
                specialArgs = {
                    extraPkgs = {
                        inherit homeManager;
                    };
                    hostName = "sootpaws-laptop-nixos";
                    theme = import themes/sunset;
                };
                modules = [
                    ./hardware/laptop.nix
                    ./general.nix
                ];
            };
            "sootpaws-rpi-nixos" = nixpkgs.lib.nixosSystem {
                specialArgs = {
                    extraPkgs = {
                        inherit homeManager;
                    };
                    hostName = "sootpaws-rpi-nixos";
                    theme = import themes/sunset;
                };
                modules = [
                    ./hardware/rpi.nix
                    ./general.nix
                ];
            };
        };
    };
}

