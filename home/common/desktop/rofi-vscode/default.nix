{ pkgs, ... }:
let
  vscode-recent = pkgs.callPackage ./vscode-recent.nix {};
in
pkgs.writeShellScript "rofi-vscode" ''
  function process() {
      while read line
      do
          [ -d "$line" ] && echo -e "$line\0icon\x1fvscode"
      done
  }

  choice="$(
    ${vscode-recent}/bin/vscode-recent --output-format absolute-path \
    | process | ${pkgs.rofi}/bin/rofi -dmenu
  )"

  if [ ! -z "$choice" ]
  then
      code --new-window "$choice"
  fi
''
