# Shorthands for common operations

deploy:
	make prepare
	sudo nixos-rebuild switch --flake .
	make cleanup

debug:
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
	touch motd.nix
	rm motd.nix
	mv ..git .git
