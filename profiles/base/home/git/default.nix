# Configuration for the Git version control system

{ settings, ... }: {
    programs.git = {
        enable = true;

        userName = settings.primaryUser.displayName;
        userEmail = "humannum14916@gmail.com";

        extraConfig.init.defaultBranch = "main";

        # Enable Git Large File Storage
        lfs.enable = true;

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
