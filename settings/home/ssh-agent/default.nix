{ config, ... }: {
    services.ssh-agent = {
        enableNushellIntegration = config.programs.nushell.enable;
    };
}
