{ config, osConfig, pkgs, ... }: let
    enable = config.programs.micro.enable;
    patchedPlugins = builtins.fetchGit {
        url = "https://github.com/humannum14916/updated-plugins.git";
        ref = "filemanager-fixes";
        rev = "7c183117ef6546ef39a8891f2d1cbac7a6ed42ab";
    };
in {
    # Needed for external clipboard
    home.packages = if enable then with pkgs; [ wl-clipboard ] else [];

    home.sessionVariables = if enable then {
        EDITOR = "micro";
        MICRO_TRUECOLOR = 1;
    } else {};

    programs.micro = {
        settings = {
            clipboard = "external";
            colorcolumn = 80;
            colorscheme = "systheme";
            diffgutter = true;
            "filemanager.openonstart" = true;
            "filemanager.showdotfiles" = false;
            "filemanager.showignored" = false;
            hlsearch = true;
            multiopen = "vsplit";
            rmtrailingws = true;
            scrollbar = true;
            scrollspeed = 8;
            statusformatl =
                "$(modified)$(filename) " +
                "($(line)/$(lines),$(col)) %$(percentage) " +
                "$(status.paste)| " +
                "$(status.branch)@$(status.hash) | " +
                "$(status.size) .$(opt:filetype) " +
                "$(opt:fileformat),$(opt.encoding)";
            statusformatr = "";
            tabmovement = true;
            tabstospaces = true;
        };
    };

    xdg.configFile = {
        microBindings = {
            inherit enable;
            source = ./bindings.json;
            target = "micro/bindings.json";
        };
        microColorScheme = {
            inherit enable;
            text = import ./colorScheme.nix osConfig.theme.colors;
            target = "micro/colorschemes/systheme.micro";
        };
        # File manager plugin
        microFileManager = {
            inherit enable;
            source = patchedPlugins.outPath + "/filemanager-plugin";
            target = "micro/plug/filemanager";
        };
    };
}
