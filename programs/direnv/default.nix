{ config, ... }: {
    programs.direnv = {
        enableNushellIntegration = config.programs.nushell.enable;
    };
}
