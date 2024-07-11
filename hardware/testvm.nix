# Hardware and basic system configuration for a test vm

{ ... }: {
    system.stateVersion = "24.05";
    nixpkgs.hostPlatform = "x86_64-linux";
}
