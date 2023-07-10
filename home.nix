{ config, pkgs, ... }: {
    home.stateVersion = "23.05";
    programs.home-manager.enable = true;

    home.username = "sootpaws";
    home.homeDirectory = "/home/sootpaws";

    home.packages = [
        pkgs.neofetch
    ];

    programs.git = {
        enable = true;

        userName = "sootpaws";
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
