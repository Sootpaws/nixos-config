# Home Manager configuration for CLI environments

{ pkgs, config, ... }: {
    # Install-only packages
    home.packages = with pkgs; [
        nerdfonts
    ];
}
