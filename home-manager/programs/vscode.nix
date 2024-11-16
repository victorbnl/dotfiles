{ nix-vscode-extensions, ... }:

{
  programs.vscode = {
    enable = true;

    userSettings = {
      "code-runner.runInTerminal" = true;
      "extensions.autoCheckUpdates" = true;
      "extensions.autoUpdate" = true;
      "git.confirmSync" = false;
      "update.mode" = "none";
      "workbench.iconTheme" = "material-icon-theme";
    };

    extensions = with nix-vscode-extensions.extensions.x86_64-linux.vscode-marketplace; [
      bbenoist.nix
      editorconfig.editorconfig
      formulahendry.code-runner
      ms-python.mypy-type-checker
      ms-python.python
      pkief.material-icon-theme
      shardulm94.trailing-spaces
    ];
  };
}
