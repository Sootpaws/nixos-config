# Shorthands for common operations

deploy:
	sudo nixos-rebuild switch --flake path:. \
		--log-format internal-json -v \
		|& nom --json

debug:
	nixos-rebuild build --flake path:. --show-trace --verbose \
		--log-format internal-json -v \
		|& nom --json

test:
	nixos-rebuild build-vm --flake path:.#testvm \
		--log-format internal-json -v \
		|& nom --json
	./result/bin/run-*
	rm result || true
	rm testvm.qcow2 || true

update:
	nix flake update
	git commit flake.lock -m "Update flake.lock"

updep:
	make update
	make deploy
