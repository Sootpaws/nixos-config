# Shorthands for common operations

deploy:
	sudo nixos-rebuild switch --flake . || true

debug:
	nixos-rebuild build --flake . --show-trace --verbose || true

update:
	nix flake update
	git restore --staged .
	git add flake.lock
	git commit -m "Update flake.lock"

updep:
	make update
	make deploy
