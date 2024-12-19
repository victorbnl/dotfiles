{
  programs.bash = {
    enable = true;

    shellAliases = {
      "rebuild-nixos" = "sudo nixos-rebuild switch --flake path:/data/victor/dotfiles";
    };
  };
}
