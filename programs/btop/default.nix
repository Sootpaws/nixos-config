{ osConfig, ... }: {
    programs.btop = {
        settings = {
            theme_background = false;
            proc_gradient = false;
        };
    };
}
