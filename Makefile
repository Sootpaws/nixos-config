# Shorthands for common operations

deploy:
	make prepare
	sudo nixos-rebuild switch --flake . || true
	make cleanup

debug:
	make prepare
	nixos-rebuild build --flake . --show-trace --verbose || true
	make cleanup

test:
	make prepare
	nixos-rebuild build-vm --flake .#testvm && ./result/bin/run-* || true
	rm result || true
	rm testvm.qcow2 || true
	make cleanup

update:
	nix flake update
	git restore --staged .
	git add flake.lock
	git commit -m "Update flake.lock"

updep:
	make update
	make deploy

# Internal build steps

prepare:
	make cleanup
	mv .git ..git

cleanup:
	mv ..git .git || true
