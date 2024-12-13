{ pkgs, ... }:

{
  home.packages = with pkgs; [
    brightnessctl
    maim
    tdrop
    xclip
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
        { command = "polybar top"; notification = false; }
        { command = "xss-lock --transfer-sleep-lock -- i3lock -c 000000"; notification = false; }
      ];

      keybindings = {
        "XF86PowerOff" = "exec --no-startup-id rofi-power-menu";

        "XF86MonBrightnessDown" = "exec --no-startup-id brightnessctl set 5%-";
        "XF86MonBrightnessUp" = "exec --no-startup-id brightnessctl set 5%+";

        "XF86AudioMute" = "exec --no-startup-id wpctl set-mute @DEFAULT_SINK@ toggle";
        "XF86AudioLowerVolume" = "exec --no-startup-id wpctl set-volume @DEFAULT_SINK@ 5%-";
        "XF86AudioRaiseVolume" = "exec --no-startup-id wpctl set-volume @DEFAULT_SINK@ 5%+";

        "${modifier}+d" = "exec --no-startup-id ${menu}";
        "${modifier}+Return" = "exec --no-startup-id ${terminal}";
        "${modifier}+e" = "exec --no-startup-id pcmanfm";

        "${modifier}+m" = "exec --no-startup-id tdrop -y 40 ${terminal} --class dropdown";

        "${modifier}+s" = "exec --no-startup-id maim --hidecursor --select --format png | xclip -selection clipboard -t image/png";
        "${modifier}+Shift+s" = "exec --no-startup-id maim --hidecursor --format png | xclip -selection clipboard -t image/png";

        "${modifier}+l" = "exec --no-startup-id loginctl lock-session";
        "${modifier}+Shift+e" = "exec --no-startup-id i3-msg exit";

        "${modifier}+Shift+q" = "kill";

        "${modifier}+Shift+c" = "reload";
        "${modifier}+Shift+r" = "restart";

        "${modifier}+b" = "splith";
        "${modifier}+v" = "splitv";

        "${modifier}+w" = "layout tabbed";
        "${modifier}+i" = "layout toggle split";

        "${modifier}+f" = "fullscreen";

        "${modifier}+space" = "focus mode_toggle";
        "${modifier}+Shift+space" = "floating toggle";

        "${modifier}+minus" = "scratchpad show";
        "${modifier}+Shift+minus" = "move scratchpad";

        "${modifier}+a" = "focus parent";

        "${modifier}+Left" = "focus left";
        "${modifier}+Down" = "focus down";
        "${modifier}+Up" = "focus up";
        "${modifier}+Right" = "focus right";

        "${modifier}+Shift+Left" = "move left";
        "${modifier}+Shift+Down" = "move down";
        "${modifier}+Shift+Up" = "move up";
        "${modifier}+Shift+Right" = "move right";

        "${modifier}+agrave" = "workspace number 1";
        "${modifier}+eacute" = "workspace number 2";
        "${modifier}+egrave" = "workspace number 3";
        "${modifier}+ecircumflex" = "workspace number 4";
        "${modifier}+parenleft" = "workspace number 5";
        "${modifier}+parenright" = "workspace number 6";
        "${modifier}+leftsinglequotemark" = "workspace number 7";
        "${modifier}+rightsinglequotemark" = "workspace number 8";
        "${modifier}+guillemotleft" = "workspace number 9";
        "${modifier}+guillemotright" = "workspace number 10";

        "${modifier}+Shift+agrave" = "move container to workspace number 1";
        "${modifier}+Shift+eacute" = "move container to workspace number 2";
        "${modifier}+Shift+egrave" = "move container to workspace number 3";
        "${modifier}+Shift+ecircumflex" = "move container to workspace number 4";
        "${modifier}+Shift+parenleft" = "move container to workspace number 5";
        "${modifier}+Shift+parenright" = "move container to workspace number 6";
        "${modifier}+Shift+leftsinglequotemark" = "move container to workspace number 7";
        "${modifier}+Shift+rightsinglequotemark" = "move container to workspace number 8";
        "${modifier}+Shift+guillemotleft" = "move container to workspace number 9";
        "${modifier}+Shift+guillemotright" = "move container to workspace number 10";
      };

      bars = [];
    };

    extraConfig = ''
      for_window [class="blueman-manager"] resize set 1200 700, move position center
      for_window [class="pavucontrol"] resize set 1200 700, move position center
    '';
  };
}
