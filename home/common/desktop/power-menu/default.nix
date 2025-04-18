{ pkgs, lib, ... }:
let
  actions = [
    { key = "p"; icon = ""; cmd = "systemctl poweroff"; }
    { key = "r"; icon = ""; cmd = "systemctl reboot"; }
    { key = "s"; icon = "󰤄"; cmd = "systemctl suspend"; }
    { key = "l"; icon = ""; cmd = "loginctl lock-session"; }
    { key = "e"; icon = "󰗼"; cmd = "i3-msg exit"; }
  ];
in
{
  home.packages = [ pkgs.nerd-fonts.ubuntu ];

  xsession.windowManager.i3.config.keybindings."XF86PowerOff" =
    "exec --no-startup-id ${import ./script.nix { inherit pkgs lib actions; }}";
}
