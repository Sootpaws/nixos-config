# Shorthands for common operations

deploy:
	mv .git ..git
	sudo nixos-rebuild switch --flake .
	mv ..git .git

debug:
	mv .git ..git
	nixos-rebuild build --flake . --show-trace --verbose
	mv ..git .git

update:
	nix flake update
