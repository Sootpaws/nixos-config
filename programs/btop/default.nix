{ osConfig, ... }: {
    programs.btop = {
        enable = true;

        settings = {
            theme_background = false;
            proc_gradient = false;
        };
    };
}
