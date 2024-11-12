{ nix-vscode-extensions, ... }:

{
  programs.vscode = {
    enable = true;

    userSettings = {
      "code-runner.runInTerminal" = true;
      "workbench.iconTheme" = "material-icon-theme";
      "git.confirmSync" = false;
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
