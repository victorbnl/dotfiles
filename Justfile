flake := "path:$(pwd)"

[parallel]
default: sys home

sys:
	sudo nixos-rebuild switch --flake {{flake}}#Marie-ThinkPad

home:
	home-manager switch --flake {{flake}}

upgrade:
	nix flake update
	just sys
	just home

installer:
	nix build {{flake}}#nixosConfigurations.installer.config.system.build.isoImage
