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

	containers = makeContainers {
	    foxtorio = let port = ports.udp.foxtorio; in {
	        autoStart = false;
	        forwardPorts = {
	            hostPort = port;
	            protocol = "udp";
	        };
	        persistPath = "/var/lib/persist";
	        config = {
	            services.factorio = {
	                enable = true;
	                allowedPlayers = (import ../../private.nix).foxtorio.allowlist;
	                autosave-interval = 15;
	                game-name = "Foxtorio";
	                description = "Yip! (The factory must grow!)";
	                inherit port;
	                saveName = "foxtorio";
	                stateDirName = "persist/factorio";
	            };
	            allowedUnfree = [ "factorio-headless" ];
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

	services.openssh.enable = true;

    networking.firewall = {
        allowedTCPPorts = builtins.attrValues ports.tcp;
        allowedUDPPorts = builtins.attrValues ports.udp;
    };
}
