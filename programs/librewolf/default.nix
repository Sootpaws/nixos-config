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
            # TODO: extensions - ublock, canvasblocker
            # TODO: search
            settings = {
                "browser.tabs.hoverPreview.enabled" = false;
                "browser.startup.homepage" = "chrome://browser/content/blanktab.html";
                "browser.newtabpage.enabled" = false;
                "extensions.update.enabled" = false;
                "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
                "webgl.disabled" = false;
                "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
                "browser.search.separatePrivateDefault" = false;
                "browser.urlbar.suggest.recentsearches" = false;
                "browser.urlbar.suggest.bookmark" = false;
                "browser.urlbar.suggest.engines" = false;
                "browser.urlbar.suggest.history" = false;
                "browser.urlbar.suggest.openpage" = false;
                "browser.urlbar.suggest.topsites" = false;
                "browser.urlbar.shortcuts.bookmarks" = false;
                "browser.urlbar.shortcuts.history" = false;
                "browser.urlbar.shortcuts.tabs" = false;
            };
            search = {
                default = "ddgn";
                engines = {
                    ddgn = {
                        name = "DuckDuckNo";
                        urls = [{
                            template = "https://noai.duckduckgo.com/?q={searchTerms}";
                        }];
                    };
                };
                force = true;
            };
            userContent = builtins.readFile ./captcha.css;
        };
    };
}
