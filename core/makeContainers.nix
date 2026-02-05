# Create a container description for a given service
containers: let
    makeContainer = name: { autoStart, forwardPorts, config }: {
        inherit autoStart forwardPorts;
        config = { imports = [ ./unfreeList.nix config ]; };
        ephemeral = true;
        # privateUsers = "pick";
        bindMounts.persist = {
            mountPoint = "/nix/persist";
            hostPath = "/nix/persist/container/${name}";
            isReadOnly = false;
        };
    };
in builtins.mapAttrs makeContainer containers
