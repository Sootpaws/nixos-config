{ ... }: {
    wayland.windowManager.sway.customConfig.openKeybinds.w = "librewolf";
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
