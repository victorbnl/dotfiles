{ lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    blueman
    handlr
    i3lock-color
    light
    maim
    nerd-fonts.ubuntu
    noto-fonts
    playerctl
    rofi-power-menu
    rofi-vscode-recent
    tdrop
    xclip
    xkill
    xss-lock
  ];

  xsession.windowManager.i3 = {
    enable = true;

    config = rec {
      modifier = "Mod4";
      terminal = "alacritty";
      menu = "rofi -show drun";

      window = {
        titlebar = false;
        border = 0;
      };

      floating = {
        titlebar = false;
        border = 0;

        criteria = [
          { class = "blueman-manager"; }
          { class = "dropdown"; }
          { class = "pavucontrol"; }
        ];
      };

      startup = [
        { command = "polybar bar"; notification = false; }
        { command = "xss-lock --transfer-sleep-lock -- i3lock-color --no-unlock-indicator --color 000000 --image ~/.background-image --fill"; notification = false; }
      ];

      fonts = {
        names = [ "Noto Sans" ];
        style = "Medium";
        size = 9.0;
      };

      colors = builtins.mapAttrs (k: v: {
        background = v.background;
        border = v.background;
        childBorder = v.background;
        indicator = v.background;
        text = v.text;
      }) {
        focused = {
          background = "#000000";
          text = "#ffffff";
        };

        focusedInactive = {
          background = "#000000";
          text = "#ffffff";
        };

        unfocused = {
          background = "#000000";
          text = "#555555";
        };

        urgent = {
          background = "#ff0000";
          text = "#ffffff";
        };
      };

      keybindings = lib.mkOptionDefault {
          "XF86MonBrightnessDown" = "exec --no-startup-id light -U 5";
          "XF86MonBrightnessUp" = "exec --no-startup-id light -A 5";

          "XF86AudioMute" = "exec --no-startup-id wpctl set-mute @DEFAULT_SINK@ toggle";
          "XF86AudioLowerVolume" = "exec --no-startup-id wpctl set-volume @DEFAULT_SINK@ 5%-";
          "XF86AudioRaiseVolume" = "exec --no-startup-id wpctl set-volume @DEFAULT_SINK@ 5%+";

          "XF86AudioPlay" = "exec --no-startup-id playerctl play-pause";

          "${modifier}+b" = "exec --no-startup-id blueman-manager";

          "XF86PowerOff" = "exec --no-startup-id rofi-power-menu";
          "${modifier}+p" = "exec --no-startup-id rofi-vscode-recent";

          "${modifier}+e" = "exec --no-startup-id handlr launch inode/directory";
          "${modifier}+n" = "exec --no-startup-id handlr launch x-scheme-handler/https";

          "${modifier}+m" = "exec --no-startup-id tdrop -y 0 ${terminal} --class dropdown";

          "${modifier}+s" = "exec --no-startup-id maim --hidecursor --select --format png | xclip -selection clipboard -t image/png";
          "${modifier}+Shift+s" = "exec --no-startup-id maim --hidecursor --format png | xclip -selection clipboard -t image/png";
          "${modifier}+Ctrl+s" = "exec --no-startup-id sleep 2 && maim --hidecursor --format png | xclip -selection clipboard -t image/png && dunstify -t 1000 'Screenshot taken'";

          "${modifier}+q" = "kill";
          "${modifier}+x" = "exec --no-startup-id xkill";

          "${modifier}+dollar" = "scratchpad show";
          "${modifier}+Shift+dollar" = "move scratchpad";
        };

      bars = [];
    };

    extraConfig = ''
      title_align center
      for_window [all] title_window_icon padding 3px

      for_window [class="blueman-manager"] resize set 1200 750, move position center
      for_window [class="pavucontrol"] resize set 1200 750, move position center
    '';
  };
}
