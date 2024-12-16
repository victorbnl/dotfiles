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
      };

      "workbench.colorCustomizations" = {
        "activityBar.background" = "#000000";
        "sideBar.background" = "#000000";
        "sideBarSectionHeader.background" = "#000000";
        "sideBarSectionHeader.border" = "#00000033";
        "sideBar.border" = "#2b2b2b";
        "statusBar.background" = "#000000";
        "titleBar.activeBackground" = "#000000";
        "titleBar.inactiveBackground" = "#000000";
        "menu.background" = "#000000";
        "editor.background" = "#000000";
        "editorGutter.background" = "#000000";
        "panel.background" = "#000000";
        "breadcrumb.background" = "#000000";
        "editorGroupHeader.tabsBackground" = "#000000";
        "tab.border" = "#000000";
        "tab.activeBackground" = "#000000";
        "tab.inactiveBackground" = "#000000";
        "widget.shadow" = "#3838385c";
        "editorWidget.background" = "#000000";
        "debugToolBar.background" = "#000000";
        "notifications.background" = "#000000";
        "notificationCenterHeader.background" = "#000000";
        "editorMarkerNavigation.background" = "#000000";
        "editorSuggestWidget.background" = "#000000";
        "editorHoverWidget.background" = "#000000";
        "minimap.background" = "#000000";
        "editorGroup.emptyBackground" = "#000000";
        "debugExceptionWidget.background" = "#000000";
      };
    };

    mutableExtensionsDir = false;

    extensions = with inputs.nix-vscode-extensions.extensions.x86_64-linux.vscode-marketplace; [
      bbenoist.nix
      editorconfig.editorconfig
      formulahendry.code-runner
      mhutchie.git-graph
      ms-python.mypy-type-checker
      ms-python.python
      ms-vsliveshare.vsliveshare
      pkgs.vscode-extensions.ms-vscode.cpptools
      pkief.material-icon-theme
      shardulm94.trailing-spaces
      tomoki1207.pdf
    ];

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
