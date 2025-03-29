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

    package = pkgs.vscode.overrideAttrs(oldAttrs: {
      buildInputs = (oldAttrs.buildInputs or []) ++ [ pkgs.tinyxxd ];
      postInstall = (oldAttrs.postInstall or "") + ''
        workbenchPath="$out/lib/vscode/resources/app/out/vs/workbench/workbench.desktop.main.css"
        cat >> "$workbenchPath" << EOF
          /* Hide window controls */
          .window-controls-container { width: 4px !important; }
          .window-controls-container > * { display: none !important; }
        EOF
        checksum="$(sha256sum -b "$workbenchPath" | xxd -r -p | base64 | sed "s/=*$//g")"
        sed -i -E 's|(^\s*"vs\/workbench\/workbench\.desktop\.main\.css": ")[^"]*("),|\1'$checksum'\2,|' "$out/lib/vscode/resources/app/product.json"
      '';
    });

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
        "window.experimentalControlOverlay" = false;
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
