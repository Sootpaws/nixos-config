# General system-level configuration for running a command-line environment

{ config, pkgs, ... }: {
    imports = [
        ../base
    ];

    # Add additional Home Manager modules
    homeManagerModules = [ ../../home/cli ];

    environment.systemPackages = with pkgs; [
        cage
        cool-retro-term
    ];

    # Launch cool-retro-term on login
    loginCommand = "cage cool-retro-term -- --fullscreen -e nu";
}
