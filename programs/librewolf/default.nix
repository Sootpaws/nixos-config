# Configuration for the Librewolf brower

{ osConfig, ... }: let
    patchedPlugins = builtins.fetchGit {
        url = "https://github.com/humannum14916/updated-plugins.git";
        ref = "filemanager-fixes";
        rev = "7c183117ef6546ef39a8891f2d1cbac7a6ed42ab";
    };
in {
    programs.librewolf = {
        enable = true;
        profiles.default = {
            # TODO: policies
            # TODO: extensions
            # TODO: search
            # TODO: settings
            settings."toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            userContent = builtins.readFile ./captcha.css;
        };
    };
}
