# Home Manager configuration for graphical environments

{ pkgs, ... }: {
    imports = [
        ./sway
        ./alacritty
    ];

    # Install-only packages
    home.packages = with pkgs; [
        nerdfonts
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
