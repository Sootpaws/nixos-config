# Shorthands for common operations

deploy:
	make cleanup
	make prepare
	sudo nixos-rebuild switch --flake .
	make cleanup

debug:
	make cleanup
	make prepare
	nixos-rebuild build --flake . --show-trace --verbose
	make cleanup

update:
	nix flake update


# Internal build steps

prepare:
	git log -n 1 --pretty=format:\"System\ configuration\ commit\ %h\ on\ %ci\" > motd.nix
	mv .git ..git

cleanup:
	rm motd.nix || true
	mv ..git .git || true
