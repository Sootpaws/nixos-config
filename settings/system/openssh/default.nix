{ config, ... }: {
	services.openssh = {
	    ports = [ 25616 ];
        banner = "meow meow meow :3\n";

        hostKeys = [ {
            type = "ed25519";
            path = "/nix/persist/etc/ssh/host_key";
        } ];
        settings = {
            PasswordAuthentication = false;
            KbdInteractiveAuthentication = false;
            PermitRootLogin = "no";
            AllowUsers = [ config.users.users.primary.name ];
        };
	    authorizedKeysInHomedir = false;
	};
	services.fail2ban.enable = config.services.openssh.enable;
}
