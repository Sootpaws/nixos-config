{ config, pkgs, ... }: {
	services.openssh = {
	    ports = [ 25616 ];

        hostKeys = [ {
            type = "ed25519";
            path = "/nix/persist/etc/ssh/host_key";
        } ];
        settings = {
            PasswordAuthentication = false;
            KbdInteractiveAuthentication = false;
            PermitRootLogin = "no";
            AllowUsers = [ config.users.users.primary.name ];
            Banner = "${ pkgs.writeText "ssh-banner" "meow meow meow :3\n" }";
        };
	    authorizedKeysInHomedir = false;
	};
	services.fail2ban.enable = config.services.openssh.enable;
}
