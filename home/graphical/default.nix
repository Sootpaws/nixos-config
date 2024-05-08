# Home Manager configuration for graphical environments

{ pkgs, config, ... }: {
    imports = [
        ../../programs/sway
        ../../programs/alacritty
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
        krita
        libreoffice
        (factorio.override (import ../../private.nix).factorio)
    ];

    # Set screenshots directory
    home.sessionVariables.XDG_SCREENSHOTS_DIR =
        config.home.homeDirectory + "/Pictures/Screenshots";

    # Link nushell scripts
    xdg.configFile.nushellScripts = {
        source = ./scripts;
        target = "nushell/scripts";
    };
}
