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
        makeSystems = import ./makeSystems.nix inputs;
        primaryUser = "sootpaws";
    in {
        nixosConfigurations = makeSystems [{
            hostName = "sootpaws-laptop-nixos";
            inherit primaryUser;
            hardware = ./hardware/laptop.nix;
            profile = ./profiles/graphical;
            theme = import themes/sunset;
        } {
            hostName = "sootpaws-rpi-nixos";
            inherit primaryUser;
            hardware = ./hardware/rpi.nix;
            profile = ./profiles/graphical;
            theme = import themes/sunset;
        }];
    };
}
