# Home Manager configuration for the primary user

primaryUser: { config, pkgs, ... }: {
    # Keep stateful data compatible with this version
    home.stateVersion = "23.05";
    # Allow Home Manager to manage itself
    programs.home-manager.enable = true;

    # General info
    home.username = primaryUser;
    home.homeDirectory = "/home/" + primaryUser;

    # Install-only packages
    home.packages = [
        pkgs.neofetch
    ];

    # Git config
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

    # Micro config
    home.sessionVariables.EDITOR = "micro";
    programs.micro = {
        enable = true;
        settings = {
            colorcolumn = 80;
            colorscheme = "cmc-16";
            diffgutter = true;
            hlsearch = true;
            multiopen = "vsplit";
            rmtrailingws = true;
            scrollbar = true;
            scrollspeed = 1;
            statusformatl =
                "$(modified)$(filename) " +
                "($(line)/$(lines),$(col)) %$(percentage) " +
                "$(status.paste)| " +
                "$(status.branch)@$(status.hash) | " +
                "$(status.size) .$(opt:filetype) " +
                "$(opt:fileformat),$(opt.encoding)";
            statusformatr = "";
            tabmovement = true;
            tabstospaces = true;
        };
    };
}
