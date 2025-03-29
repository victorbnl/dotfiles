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

    profiles.default = {
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;

      extensions = with inputs.nix-vscode-extensions.extensions.x86_64-linux.vscode-marketplace; [
        bbenoist.nix
        editorconfig.editorconfig
        formulahendry.code-runner
        mechatroner.rainbow-csv
        mkhl.direnv
        ms-vsliveshare.vsliveshare
        pkief.material-icon-theme
        shardulm94.trailing-spaces
        tomoki1207.pdf
      ];

      userSettings = {
        "editor.rulers" = [ 80 ];
        "git.confirmSync" = false;
        "window.commandCenter" = false;
        "window.dialogStyle" = "custom";
        "window.titleBarStyle" = "custom";
        "workbench.colorTheme" = "Dark Modern";
        "workbench.iconTheme" = "material-icon-theme";

        "files.exclude" = {
          "**/.mypy_cache" = true;
          "**/__pycache__" = true;
          "**/.devenv*" = true;
          "**/.venv" = true;
        };

        "direnv.restart.automatic" = true;

        "[nix]" = {
          "editor.tabSize" = 2;
        };
      };
    };
  };
}
