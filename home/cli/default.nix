# Home Manager configuration for CLI environments

{ pkgs, config, ... }: {
    imports = [
        ../../programs/cool-retro-term
        ../../programs/zellij
    ];

    # Install-only packages
    home.packages = with pkgs; [
        nerdfonts
    ];
}
