# Shorthands for common operations

deploy:
	make prepare
	sudo nixos-rebuild switch --flake . || true
	make cleanup

debug:
	make prepare
	nixos-rebuild build --flake . --show-trace --verbose || true
	make cleanup

update:
	nix flake update


# Internal build steps

prepare:
	make cleanup
	echo "\"System configuration commit: $$(git branch --show-current)@\
	$$(git log -n 1 --pretty=format:%h\ on\ %ci)\"" > motd.nix
	mv .git ..git

cleanup:
	rm motd.nix || true
	mv ..git .git || true
