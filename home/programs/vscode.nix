{ pkgs, lib, inputs, ... }:

{
  programs.vscode = {
    enable = true;

    mutableExtensionsDir = false;

    profiles.default = {
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;

      extensions = with inputs.nix-vscode-extensions.extensions.x86_64-linux.vscode-marketplace; [
        bbenoist.nix
        eamodio.gitlens
        editorconfig.editorconfig
        formulahendry.code-runner
        mechatroner.rainbow-csv
        mkhl.direnv
        ms-vsliveshare.vsliveshare
        myriad-dreamin.tinymist
        pkief.material-icon-theme
        shardulm94.trailing-spaces
        tomoki1207.pdf
        vstirbu.vscode-mermaid-preview
      ];

      userSettings =
        with lib;
        let
          forLangs = langs: opts: genAttrs (map (x: "[${x}]") langs) (_: opts);
        in
        {
          "window.commandCenter" = false;
          "window.controlsStyle" = "hidden";
          "window.dialogStyle" = "custom";
          "window.titleBarStyle" = "custom";

          "workbench.colorTheme" = "Dark Modern";
          "workbench.editor.empty.hint" = "hidden";
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
        }
        // forLangs [
          "markdown"
          "plaintext"
          "typst"
        ] {
          "editor.wordWrap" = "wordWrapColumn";
          "editor.wordWrapColumn" = 60;
        };
    };
  };
}
