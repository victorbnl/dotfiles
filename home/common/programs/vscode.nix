{ pkgs, inputs, ... }:

{
  programs.vscode = {
    enable = true;

    mutableExtensionsDir = false;

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
        myriad-dreamin.tinymist
        pkief.material-icon-theme
        shardulm94.trailing-spaces
        tomoki1207.pdf
      ];

      userSettings = {
        "window.commandCenter" = false;
        "window.controlsStyle" = "hidden";
        "window.dialogStyle" = "custom";
        "window.titleBarStyle" = "custom";

        "workbench.colorTheme" = "Dark Modern";
        "workbench.iconTheme" = "material-icon-theme";

        "editor.rulers" = [ 80 ];
        "git.confirmSync" = false;
        "direnv.restart.automatic" = true;

        "files.exclude" = {
          "**/.mypy_cache" = true;
          "**/__pycache__" = true;
          "**/.devenv*" = true;
          "**/.venv" = true;
        };

        "[nix]" = {
          "editor.tabSize" = 2;
        };
      };
    };
  };
}
