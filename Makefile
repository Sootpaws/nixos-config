# Shorthands for common operations

deploy:
	sudo nixos-rebuild switch --flake .

debug:
	nixos-rebuild build --flake . --show-trace --verbose

update:
	nix flake update
