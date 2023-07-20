# Home Manager configuration for the primary user

primaryUser: { config, pkgs, ... }: {
    imports = [
        ./sway
        ./nushell
        ./micro
    ];

    # Keep stateful data compatible with this version
    home.stateVersion = "23.05";
    # Allow Home Manager to manage itself
    programs.home-manager.enable = true;

    # General info
    home.username = primaryUser;
    home.homeDirectory = "/home/" + primaryUser;

    # Have Home Manager manage XDG directories
    xdg.enable = true;

    # Enable fontconfig
    fonts.fontconfig.enable = true;

    # Install-only packages
    home.packages = [
        pkgs.neofetch
    ];

    # Alacritty, terminal emulator
    programs.alacritty = {
        enable = true;

        settings = {
            # Functional
            shell = { program = "nu"; };
            # Visual
            window.opacity = 0.5;
            colors.transparent_background_colors = true;
        };
    };

    # Starship, prompt
    programs.starship = {
        enable = true;
        # This will be used with Nushell
        enableNushellIntegration = true;
    };

    # Librewolf, web browser
    programs.librewolf = {
        enable = true;
    };

    # Git, version control tool
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
