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
        primaryUser = {
            systemName = "sootpaws";
            displayName = "Sootpaws";
            email = "sootpaws@proton.me";
        };
    in {
        nixosConfigurations = makeSystems [{
            hostName = "sootpaws-laptop-nixos";
            inherit primaryUser;
            modules = [
                ./hardware/laptop.nix
                ./profiles/graphical
                ./themes/sunset
            ];
        } {
            hostName = "sootpaws-rpi-nixos";
            inherit primaryUser;
            modules = [
                ./hardware/rpi.nix
                ./profiles/graphical
                ./themes/sunset
            ];
        }];
    };
}
