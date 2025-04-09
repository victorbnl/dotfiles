.PHONY: installer sys home

flake = "path:$(shell pwd)"

installer:
	nix build ${flake}#nixosConfigurations.installer.config.system.build.isoImage

sys:
	nixos-rebuild switch --flake ${flake}

home:
	home-manager switch --flake ${flake}
