{ pkgs, inputs, ... }:

{
  xdg.desktopEntries = {
    code-tempdir = {
      name = "Visual Studio Code (temporary directory)";
      genericName = "Text Editor";
      exec = "bash -c \"code \\\\$(mktemp -d)\"";
      icon = "vscode";
    };
  };

  programs.vscode = {
    enable = true;

    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;

    userSettings = {
      "code-runner.runInTerminal" = true;
      "git.confirmSync" = false;
      "window.dialogStyle" = "custom";
      "window.titleBarStyle" = "custom";
      "workbench.iconTheme" = "material-icon-theme";
    };

    mutableExtensionsDir = false;

    extensions = with inputs.nix-vscode-extensions.extensions.x86_64-linux.vscode-marketplace; [
      bbenoist.nix
      editorconfig.editorconfig
      formulahendry.code-runner
      ms-python.mypy-type-checker
      ms-python.python
      pkgs.vscode-extensions.ms-vscode.cpptools
      pkief.material-icon-theme
      shardulm94.trailing-spaces
      tomoki1207.pdf
    ];
  };
}
