{
    description = "NixOS configuration for sootpaws-rpi-nixos";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs@{ nixpkgs, home-manager, ... }: {
        nixosConfigurations = {
            "sootpaws-rpi-nixos" = nixpkgs.lib.nixosSystem {
                specialArgs = {
                    extra-pkgs = {
                        inherit home-manager;
                    };
                    hostName = "sootpaws-rpi-nixos";
                };
                modules = [
                    ./hardware/rpi.nix
                    ./general.nix
                ];
            };
        };
    };
}

