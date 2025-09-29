{
  lib,
  rofi,
  writeShellApplication,
  writeText
}:
let
  actions = [
    { key = "p"; icon = ""; cmd = "systemctl poweroff"; }
    { key = "r"; icon = ""; cmd = "systemctl reboot"; }
    { key = "s"; icon = "󰤄"; cmd = "systemctl suspend"; }
    { key = "l"; icon = ""; cmd = "loginctl lock-session"; }
    { key = "e"; icon = "󰗼"; cmd = "i3-msg exit"; }
  ];

  config =
    let
      kb-select = index: action: "kb-select-${toString index}: \"${action.key}\";";
      kb-selects = lib.concatImapStringsSep "\n" kb-select actions;
    in
    writeText "config.rasi" ''
      @import "config.rasi"

      configuration {
          show-icons: false;
          ${kb-selects}
      }

      window {
          width: 800px;
      }

      mainbox {
          children: [listview];
      }

      listview {
          columns: 5;
          lines: 1;
          cycle: true;
          spacing: 15px;
      }

      element {
          padding: 40px 10px;
          text-color: @foreground;
          cursor: pointer;
      }
      element-text {
          font: "Ubuntu Nerd Font 32";
          cursor: inherit;
          vertical-align: 0.5;
          horizontal-align: 0.5;
      }
    '';
in
writeShellApplication {
  name = "rofi-power-menu";
  runtimeInputs = [ rofi ];

  text =
    let
      input = lib.concatMapStringsSep "\\n" (action: action.icon) actions;
      case = action: "${action.icon}) ${action.cmd} ;;";
      cases = lib.concatMapStringsSep "\n" case actions;
    in
    ''
      choice=$(echo -e "${input}" | rofi -dmenu -config ${config})

      case $choice in
        ${cases}
      esac
    '';
}
