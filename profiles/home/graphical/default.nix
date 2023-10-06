# Home Manager configuration for graphical environments

{ pkgs, ... }: {
    imports = [
        ../base
        ./sway
        ./alacritty
    ];

    # Install-only packages
    home.packages = with pkgs; [
        shotman
        pavucontrol
        librewolf
        tor-browser-bundle-bin
        keepassxc
        helm
        gimp
        libreoffice
    ];
}
