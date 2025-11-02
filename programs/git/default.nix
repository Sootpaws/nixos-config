# Configuration for the Git version control system

{ osConfig, ... }: {
    programs.git = {
        enable = true;

        settings = {
            user = {
                name = osConfig.primaryUserInfo.displayName;
                email = osConfig.primaryUserInfo.email;
            };

            init.defaultBranch = "main";

            alias = {
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
    };

    programs.delta = {
        enable = true;
        enableGitIntegration = true;
        options = {
            features = "side-by-side";
        };
    };
}
