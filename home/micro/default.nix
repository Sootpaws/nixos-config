# Configuration for the Micro text editor

{ config, pkgs, settings, ... }: let
    patchedPlugins = builtins.fetchGit {
        url = "https://github.com/humannum14916/updated-plugins.git";
        ref = "filemanager-fixes";
        rev = "7c183117ef6546ef39a8891f2d1cbac7a6ed42ab";
    };
in {
    # Set Micro as the main editor
    home.sessionVariables.EDITOR = "micro";
    # Enable true-color
    home.sessionVariables.MICRO_TRUECOLOR = 1;
    # settings.json config, directly configurable through Nix
    programs.micro = {
        # Actually enable Micro
        enable = true;
        settings = {
            # Use the terminal emulator for clipboard
            clipboard = "terminal";
            # Highlight column 80
            colorcolumn = 80;
            # Set the color scheme
            colorscheme = "systheme";
            # Enable the diff gutter
            diffgutter = true;
            # Open the file manager on startup
            "filemanager.openonstart" = true;
            # Don't show dotfiles in the file tree
            "filemanager.showdotfiles" = false;
            # Don't show files ignored by VCS
            "filemanager.showignored" = false;
            # Keep search results highlighted
            hlsearch = true;
            # Open multiple files as vertical splits
            multiopen = "vsplit";
            # Trim trailing whitespace from lines
            rmtrailingws = true;
            # Enable the scroll bar
            scrollbar = true;
            # Set scroll speed
            scrollspeed = 8;
            # Status line format (left side)
            statusformatl =
                "$(modified)$(filename) " +
                "($(line)/$(lines),$(col)) %$(percentage) " +
                "$(status.paste)| " +
                "$(status.branch)@$(status.hash) | " +
                "$(status.size) .$(opt:filetype) " +
                "$(opt:fileformat),$(opt.encoding)";
            # Don't show anything on the right side of the status bar
            statusformatr = "";
            # Treat spaces like tabs for cusror movement
            tabmovement = true;
            # Use spaces instead of tabs
            tabstospaces = true;
        };
    };
    # Directly-linked config files
    xdg.configFile = {
        # bindings.json
        microBindings = {
            source = ./bindings.json;
            target = "micro/bindings.json";
        };
        # Color scheme
        microColorScheme = {
            text = import ./colorScheme.nix settings.theme.colors;
            target = "micro/colorschemes/systheme.micro";
        };
        # File manager plugin
        microFileManager = {
            source = patchedPlugins.outPath + "/filemanager-plugin";
            target = "micro/plug/filemanager";
        };
    };
}
