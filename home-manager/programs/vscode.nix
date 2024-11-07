{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;

    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      editorconfig.editorconfig
      formulahendry.code-runner
      shardulm94.trailing-spaces
    ];
  };
}