{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;

    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      formulahendry.code-runner
      shardulm94.trailing-spaces
    ];
  };
}