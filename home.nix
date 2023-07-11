primaryUser: { config, pkgs, ... }: {
    home.stateVersion = "23.05";
    programs.home-manager.enable = true;

    home.username = primaryUser;
    home.homeDirectory = "/home/" + primaryUser;

    home.packages = [
        pkgs.neofetch
    ];

    programs.git = {
        enable = true;

        userName = "Sootpaws";
        userEmail = "humannum14916@gmail.com";

        # Enable Git Large File Storage
        lfs.enable = true;

        # Enable the Delta diff highlighter
        delta = {
            enable = true;
            options = {
                features = "side-by-side";
            };
        };
    };
}
