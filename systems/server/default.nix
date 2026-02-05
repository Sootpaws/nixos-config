{ ... }: let
    makeContainers = import ../../core/makeContainers.nix;
in {
	imports = [ ../base ];

	loginCommand = "zellij";

	containers = makeContainers {
	    snepcraft = let port = 25664; in {
	        autoStart = false;
	        forwardPorts.hostPort = port;
	        config = { lib, ... }: {
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
	                whitelist = (import ../../private.nix).snepcraft.whitelist;
	            };
	            allowedUnfree = [ "minecraft-server"];
	            system.stateVersion = "26.01";
	        };
	    };
	};

    networking.firewall.allowedTCPPorts = [ 25664 ];
}
