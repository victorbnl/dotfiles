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
    FOLDER="$HOME/dev"

    function process() {
      while read -r line; do
        [ -d "$line" ] && [[ "$line" = "$FOLDER/"* ]] && echo -e "''${line##"$FOLDER/"}\0icon\x1fvscode"
      done
    }

    choice="$(vscode-recent --output-format absolute-path | process | rofi -dmenu)"

    [ -n "$choice" ] && code --new-window "$FOLDER/$choice"
  '';
}
