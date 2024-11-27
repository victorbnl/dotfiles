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
      "window.commandCenter" = false;
      "window.dialogStyle" = "custom";
      "window.experimentalControlOverlay" = false;
      "window.titleBarStyle" = "custom";
      "workbench.colorTheme" = "Styx Material";
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

      (hshhrr.styx.overrideAttrs (oldAttrs: {
        postInstall = (oldAttrs.postInstall or "") + ''
          find $out -name "styx*-color-theme.json" \
            -exec sed -i "s/#0A3329/#303030/g" "{}" \; \
            -exec sed -i "s/#91F2DA/#FFFFFF/g" "{}" \; \
            -exec sed -i -E 's/("widget\.shadow": )"#000000"/\1"#202020"/g' "{}" \;
        '';
      }))
    ];

    # mostly taken from https://github.com/KatsuteDev/Background/
    package = pkgs.vscode.overrideAttrs(oldAttrs: {
      buildInputs = (oldAttrs.buildInputs or []) ++ [ pkgs.tinyxxd ];
      postInstall = (oldAttrs.postInstall or "") + ''
        workbenchPath="$out/lib/vscode/resources/app/out/vs/workbench/workbench.desktop.main.css"
        cat >> "$workbenchPath" << EOF
          /* Hide window controls */
          .window-controls-container { width: 4px !important; }
          .window-controls-container > * { display: none !important; }

          /* Background */
          body::after{
            content: "";
            display: block;
            position: absolute;
            z-index: 1000;
            inset: 0;
            background-image: url("vscode-file://vscode-app/home/victor/.vscode-background-image.jpg");
            background-size: cover;
            background-position: center;
            pointer-events: none;
            opacity: 0.2;
            mix-blend-mode: lighten;
          }
        EOF
        checksum="$(sha256sum -b "$workbenchPath" | xxd -r -p | base64 | sed "s/=*$//g")"
        sed -i -E 's|(^\s*"vs\/workbench\/workbench\.desktop\.main\.css": ")[^"]*("),|\1'$checksum'\2,|' "$out/lib/vscode/resources/app/product.json"
      '';
    });
  };
}
