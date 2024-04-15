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
    in {
        nixosConfigurations = makeSystems [{
            hostName = "sootpaws-laptop-nixos";
            modules = [
                ./hardware/laptop.nix
                ./system/graphical
                ./users/sootpaws.nix
                ./themes/sunset
            ];
        } {
            hostName = "sootpaws-rpi-nixos";
            modules = [
                ./hardware/rpi.nix
                ./system/graphical
                ./users/sootpaws.nix
                ./themes/sunset
            ];
        }];
    };
}
