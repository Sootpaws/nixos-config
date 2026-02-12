{ config, osConfig, ... }: {
    programs.git = {
        settings = {
            user = {
                name = osConfig.primaryUserInfo.displayName;
                email = osConfig.primaryUserInfo.email;
            };

            init.defaultBranch = "main";
            pull.rebase = true;

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
        enable = config.programs.git.enable;
        enableGitIntegration = true;
        options = {
            features = "side-by-side";
        };
    };
}
