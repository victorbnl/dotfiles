.PHONY: sys home

flake = "path:$(shell pwd)"

sys:
	nixos-rebuild switch --flake ${flake}

home:
	home-manager switch --flake ${flake}
