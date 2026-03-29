# Create a container description for a given service
containers: let
    makeContainer = name: { autoStart, forwardPorts, config, persistPath ? "/nix/persist" }: {
        inherit autoStart forwardPorts;
        config = {
            imports = [ ./unfreeList.nix config ];
            # TODO: Does this even matter? (ephemeral containers)
            system.stateVersion = "26.01";
        };
        ephemeral = true;
        privateUsers = "pick";
        bindMounts.persist = {
            mountPoint = persistPath;
            hostPath = "/nix/persist/container/${name}";
            isReadOnly = false;
        };
    };
in builtins.mapAttrs makeContainer containers
