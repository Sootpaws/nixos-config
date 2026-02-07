{ ... }: {
    services.ssh-agent = {
        enable = true;
        enableNushellIntegration = true;
    };
}
