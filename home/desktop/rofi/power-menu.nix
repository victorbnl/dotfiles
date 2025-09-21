{ pkgs, lib, ... }:
let
  actions = [
    { key = "p"; icon = ""; cmd = "systemctl poweroff"; }
    { key = "r"; icon = ""; cmd = "systemctl reboot"; }
    { key = "s"; icon = "󰤄"; cmd = "systemctl suspend"; }
    { key = "l"; icon = ""; cmd = "loginctl lock-session"; }
    { key = "e"; icon = "󰗼"; cmd = "i3-msg exit"; }
  ];

  config = pkgs.writeText "config.rasi" ''
    @import "config.rasi"

    configuration {
        show-icons: false;

        ${
          lib.concatImapStringsSep "\n"
          (i: a: "kb-select-${toString i}: \"${a.key}\";")
          actions
        }
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

  script = with lib; ''
    choice=$(
      echo -e "${concatMapStringsSep "\\n" (a: a.icon) actions}" \
        | rofi -dmenu -config ${config}
    )

    case $choice in
      ${
        concatMapStringsSep "\n"
        (a: "${a.icon}) ${a.cmd} ;;")
        actions
      }
    esac
  '';
in
pkgs.writeShellScript "power-menu" script
