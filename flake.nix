{
    description = "NixOS configuration for sootpaws-*-nixos";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        sops-nix = {
            url = "github:Mic92/sops-nix";
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
        nixosConfigurations = makeSystems {
            sootpaws-laptop-nixos = [
                ./hardware/laptop
                ./systems/workstation
                ./users/sootpaws.nix
                ./themes/sunset
            ];
            sootpaws-server-nixos = [
                ./hardware/thinkpad
                ./systems/server
                ./users/sootpaws.nix
                ./themes/sunset
            ];
            sootpaws-rpi-nixos = [
                ./hardware/rpi
                ./systems/workstation
                ./users/sootpaws.nix
                ./themes/sunset
            ];
        };
        devShells.x86_64-linux.default = let
            pkgs = nixpkgs.legacyPackages.x86_64-linux;
        in pkgs.mkShell {
            packages = with pkgs; [
                git
                gnumake
                nix-output-monitor
                sops
            ];
        };
    };
}
