{
    description = "NixOS configuration for sootpaws-rpi-nixos";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
        home-manager = {
            url = "github:nix-community/home-manager/release-23.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs@{ nixpkgs, home-manager, ... }: {
        nixosConfigurations = {
            "sootpaws-rpi-nixos" = nixpkgs.lib.nixosSystem {
                specialArgs = { inherit home-manager; };
                modules = [
                    ./system_rpi.nix
                    ./configuration_main.nix
                ];
            };
        };
    };
}

