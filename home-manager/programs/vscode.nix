{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;

    userSettings = {
      "workbench.iconTheme" = "material-icon-theme";
      "git.confirmSync" = false;
    };

    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      editorconfig.editorconfig
      formulahendry.code-runner
      pkief.material-icon-theme
      shardulm94.trailing-spaces
    ];
  };
}
