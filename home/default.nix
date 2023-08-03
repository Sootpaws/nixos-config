# Home Manager configuration for the primary user

{ lib, config, pkgs, settings, primaryUser, ... }: {
    imports = [
        ./sway
        ./alacritty
        ./nushell
        ./starship
        ./micro
        ./git
    ];

    # Keep stateful data compatible with this version
    home.stateVersion = "23.05";
    # Allow Home Manager to manage itself
    programs.home-manager.enable = true;

    # General info
    home.username = primaryUser;
    home.homeDirectory = "/home/" + primaryUser;

    # Have Home Manager manage XDG directories
    xdg.enable = true;

    # Enable fontconfig
    fonts.fontconfig.enable = true;

    # Install-only packages
    home.packages = [
        pkgs.nerdfonts
        pkgs.du-dust
        pkgs.neofetch
    ];

    # Librewolf, web browser
    programs.librewolf = {
        enable = true;
        settings = {
            "privacy.clearOnShutdown.history" = false;
            "browser.sessionstore.resume_from_crash" = false;
            "browser.warnOnQuitShortcut" = false;
            "browser.startup.homepage" = "chrome://browser/content/blanktab.html";
            "browser.newtabpage.enabled" = false;
            "browser.search.hiddenOneOffs" = "DuckDuckGo,DuckDuckGo Lite,MetaGer,SearXNG - searx.be,StartPage,Wikipedia (en)";
            "browser.urlbar.shortcuts.bookmarks" = false;
            "browser.urlbar.shortcuts.history" = false;
            "browser.urlbar.shortcuts.tabs" = false;
            "browser.toolbars.bookmarks.visibility" = "always";
            "browser.bookmarks.addedImportButton" = true;
        };
    };
}
