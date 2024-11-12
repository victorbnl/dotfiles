{ pkgs, nix-vscode-extensions, ... }:

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
      nix-vscode-extensions.extensions.x86_64-linux.vscode-marketplace.ms-python.mypy-type-checker
      ms-python.python
      pkief.material-icon-theme
      shardulm94.trailing-spaces
    ];
  };
}
