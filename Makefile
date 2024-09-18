# Shorthands for common operations

deploy:
	sudo nixos-rebuild switch --flake path:. || true

debug:
	nixos-rebuild build --flake path:. --show-trace --verbose || true

test:
	nixos-rebuild build-vm --flake path:.#testvm && ./result/bin/run-* || true
	rm result || true
	rm testvm.qcow2 || true

update:
	nix flake update
	git commit flake.lock -m "Update flake.lock"

updep:
	make update
	make deploy
