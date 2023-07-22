# Home Manager configuration for the primary user

{ lib, config, pkgs, theme, primaryUser, ... }: {
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
        pkgs.nerdfonts
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
            font = { family = theme.font; };
        };
    };

    # Starship, prompt
    programs.starship = {
        enable = true;
        # This will be used with Nushell
        enableNushellIntegration = true;

        settings = {
            add_newline = false;

            palettes.system = {
                pe = theme.colors.primary.extra;
                ps = theme.colors.primary.strong;
                pm = theme.colors.primary.medium;
                pw = theme.colors.primary.weak;

                se = theme.colors.secondary.extra;
                ss = theme.colors.secondary.strong;
                sm = theme.colors.secondary.medium;
                sw = theme.colors.secondary.weak;

                ae = theme.colors.accent.extra;
                as = theme.colors.accent.strong;
                am = theme.colors.accent.medium;
                aw = theme.colors.accent.weak;
            };
            palette = "system";

            format = lib.concatStrings [
                "[           ](bg:pe)[](fg:pe bg:ps)["
                " $username@$hostname:$localip "
                "](bg:ps)[](fg:ps bg:pm)["
                "( $package$rust)"
                "](bg:pm)[](fg:pm)$line_break"
                "[      ](bg:as)[](fg:as bg:am)["
                " $directory$nix_shell"
                "](bg:am)[](fg:am bg:aw)["
                "( $git_branch@$git_commit$git_state$git_status$git_metrics)"
                "](bg:aw)[](fg:aw)$line_break"
                "[ ](bg:ss)[](fg:ss) "
            ];
            right_format = lib.concatStrings [
                "[](fg:aw)["
                "( $status)"
                "](bg:aw)"
                "[](fg:am bg:aw)["
                " $cmd_duration"
                "](bg:am)[](fg:as bg:am)[ ](bg:as)"
            ];

            username = {
                show_always = true;
                format = "[$user]($style bg:ps)";
            };
            hostname = {
                ssh_only = false;
                trim_at = "";
                format = "[$ssh_symbol$hostname]($style bg:ps)";
            };
            localip = {
                ssh_only = false;
                disabled = false;
                format = "[$localipv4]($style bg:ps)";
            };
            package = {
                format = "[$symbol$version]($style bg:pm) ";
            };
            rust = {
                symbol = "";
                format = "[$symbol( $version)]($style bg:pm) ";
            };
            directory = {
                truncation_symbol = ".../";
                format = lib.concatStrings [
                    "[$path]($style bg:am)"
                    "[$read_only]($read_only_style bg:am) "
                ];
            };
            nix_shell = {
                format = "[$symbol$state(\($name\))]($style bg:am)";
            };
            git_branch = {
                always_show_remote = true;
                format = "[$symbol$branch(:$remote_branch)]($style bg:aw)";
            };
            git_commit = {
                only_detached = false;
                tag_disabled = false;
                format = "[$hash$tag]($style) ";
                style = "bold green bg:aw";
            };
            git_state = {
                style = "bold yellow bg:aw";
            };
            git_status = {
                style = "bold red bg:aw";
            };
            git_metrics = {
                disabled = false;
                added_style = "bold green bg:aw";
                deleted_style = "bold red bg:aw";
            };
            status = {
                disabled = false;
                pipestatus = true;
                style = "bold red bg:aw";
            };
            cmd_duration = {
                min_time = 0;
                show_milliseconds = true;
                format = "[$duration]($style) ";
                style = "bold yellow bg:am";
            };
        };
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
