# Configuration for the Git version control system

{ ... }: {
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
