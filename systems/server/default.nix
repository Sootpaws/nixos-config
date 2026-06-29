{ config, ... }: let
    makeContainers = import ../../core/makeContainers.nix;
    ports = {
        tcp = {
            snepcraft = 25664;
        };
        udp = {
            foxtorio = 25632;
        };
    };
in {
	imports = [ ../base ];

    # Disable sleep when closed and plugged in
	services.logind.settings.Login.HandleLidSwitchExternalPower = "ignore";

	loginCommand = "zellij";
	home-manager.users.primary.programs.zellij.config.modifier = [ "Super" ];

	serviceContainers = {
	    foxtorio = let port = ports.udp.foxtorio; in {
	        autoStart = false;
	        forwardPorts = {
	            hostPort = port;
	            protocol = "udp";
	        };
	        config = args@{ ... }: {
	            services.factorio = {
	                enable = true;
	                allowedPlayers = (import ../../private.nix).foxtorio.allowlist;
	                autosave-interval = 15;
	                game-name = "Foxtorio";
	                description = "Yip! (The factory must grow!)";
	                inherit port;
	                saveName = "foxtorio";
	            };
	            allowedUnfree = [ "factorio-headless" ];
	            # Putting the save files in /nix/persist
	            systemd.services.factorio = {
	                # Horrible hack because lib.mkBefore doesn't work somehow
    	            preStart = let
    	                cfg = args.config.services.factorio;
    	                stateDir = "/var/lib/${cfg.stateDirName}";
    	                savePath = "${stateDir}/saves/${cfg.saveName}.zip";
    	            in toString [
    	                "mkdir -p /nix/persist/factorio\n"
    	                "mv ${stateDir}/saves ${stateDir}/new_save\n"
                        "ln -s /nix/persist/factorio ${stateDir}/saves\n"
                        "test -e ${savePath} || mv ${stateDir}/new_save/* ${stateDir}/saves\n"
                        "rm -r ${stateDir}/new_save"
    	            ];
	                serviceConfig.ReadWritePaths = "/nix/persist";
    	        };
	        };
	    };
	    snepcraft = let port = ports.tcp.snepcraft; in {
	        autoStart = false;
	        forwardPorts.hostPort = port;
	        config = {
	            services.minecraft-server = {
	                enable = true;
	                dataDir = "/nix/persist/minecraft";
	                declarative = true;
	                eula = true;
	                serverProperties = {
	                    difficulty = "normal";
	                    motd = "Mrow :3";
	                    server-port = port;
	                    white-list = true;
	                };
	                whitelist = (import ../../private.nix).snepcraft.allowlist;
	            };
	            allowedUnfree = [ "minecraft-server"];
	        };
	    };
	};

    networking.firewall = {
        allowedTCPPorts = builtins.attrValues ports.tcp;
        allowedUDPPorts = builtins.attrValues ports.udp;
    };
}
