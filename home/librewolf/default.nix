# Librewolf, web browser

{ ... }: {
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
