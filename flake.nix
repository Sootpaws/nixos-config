{
    description = "NixOS configuration for sootpaws-*-nixos";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        homeManager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        disko = {
            url = "github:nix-community/disko";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs@{ nixpkgs, ... }: let
        makeSystems = import ./core/makeSystems.nix inputs;
    in {
        nixosConfigurations = makeSystems [{
            hostName = "sootpaws-laptop-nixos";
            modules = [
                ./hardware/laptop
                ./systems/workstation
                ./users/sootpaws.nix
                ./themes/sunset
            ];
        } {
            hostName = "sootpaws-server-nixos";
            modules = [
                ./hardware/thinkpad
                ./systems/server
                ./users/sootpaws.nix
                ./themes/sunset
            ];
        } {
            hostName = "sootpaws-rpi-nixos";
            modules = [
                ./hardware/rpi
                ./systems/workstation
                ./users/sootpaws.nix
                ./themes/sunset
            ];
        }];
        devShells.x86_64-linux.default = let
            pkgs = nixpkgs.legacyPackages.x86_64-linux;
        in pkgs.mkShell {
            packages = with pkgs; [
                git
                gnumake
                nix-output-monitor
            ];
        };
    };
}
