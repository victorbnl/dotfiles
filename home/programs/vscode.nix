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

    # mostly taken from https://github.com/KatsuteDev/Background/
    package = pkgs.vscode.overrideAttrs(oldAttrs: {
      buildInputs = (oldAttrs.buildInputs or []) ++ [ pkgs.tinyxxd ];
      postInstall = (oldAttrs.postInstall or "") + ''
        workbenchPath="$out/lib/vscode/resources/app/out/vs/workbench/workbench.desktop.main.css"
        cat >> "$workbenchPath" << EOF
          // Hide window controls
          .window-controls-container { width: 4px !important; }
          .window-controls-container > * { display: none !important; }
        EOF
        checksum="$(sha256sum -b "$workbenchPath" | xxd -r -p | base64 | sed "s/=*$//g")"
        sed -i -E 's|(^\s*"vs\/workbench\/workbench\.desktop\.main\.css": ")[^"]*("),|\1'$checksum'\2,|' "$out/lib/vscode/resources/app/product.json"
      '';
    });
  };
}
