# Configuration for the Git version control system

{ osConfig, ... }: {
    programs.git = {
        enable = true;

        userName = osConfig.primaryUserInfo.displayName;
        userEmail = osConfig.primaryUserInfo.email;

        extraConfig.init.defaultBranch = "main";

        # Enable the Delta diff highlighter
        delta = {
            enable = true;
            options = {
                features = "side-by-side";
            };
        };

        aliases = {
            s = "status";
            a = "add";
            aa = "add .";
            r = "restore";
            d = "diff";
            dc = "diff --cached";
            c = "commit";
            ca = "commit --amend";
            u = "reset --soft HEAD^";
            l = "log -n 3";
            la = "log";
        };
    };
}
