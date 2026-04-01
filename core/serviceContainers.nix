{ lib, config, ... }: let
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
    createPersist = containers: builtins.listToAttrs (builtins.map (name: {
        name = "container@${name}";
        value = let dir = "/nix/persist/container/${name}"; in {
            preStart = ''
                mkdir --parents ${dir}
                chmod a+rwx ${dir}
            '';
        };
    }) (builtins.attrNames containers));
in {
    options = with lib; with types; {
        serviceContainers = mkOption {
            type = attrsOf (submodule { options = {
                autoStart = mkOption { type = bool; };
                forwardPorts = mkOption {
                    type = submodule {
                        hostPort = mkOption { type = port; };
                        protocol = mkOption { type = str; };
                    };
                    default = {};
                };
                config = mkOption { type = anything; };
                persistPath = mkOption {
                    type = str;
                    default = "/nix/persist";
                };
            }; });
            default = {};
        };
    };
    config = {
        # Main container definitions
        containers = builtins.mapAttrs makeContainer config.serviceContainers;

        # Persistent directory creation
        systemd.services = createPersist config.serviceContainers;
    };
}
