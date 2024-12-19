{
  programs.bash.enable = true;

  home.shellAliases = {
    "rebuild-nixos" = "sudo nixos-rebuild switch --flake path:/data/victor/dotfiles";
  };
}
