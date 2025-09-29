{
  callPackage,
  rofi,
  writeShellApplication,
  vscode,
  vscode-recent
}:

writeShellApplication {
  name = "rofi-vscode-recent";

  runtimeInputs = [
    rofi
    vscode
    vscode-recent
  ];

  bashOptions = [];

  text = ''
    function process() {
      while read -r line; do
        [ -d "$line" ] && echo -e "$line\0icon\x1fvscode"
      done
    }

    choice="$(vscode-recent --output-format absolute-path | process | rofi -dmenu)"

    [ -n "$choice" ] && code --new-window "$choice"
  '';
}
