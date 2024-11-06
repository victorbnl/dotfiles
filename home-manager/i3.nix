{
  xsession.windowManager.i3 = {
    enable = true;

    config = rec {
      modifier = "Mod4";
      terminal = "alacritty";
      menu = "dmenu_run";

      window = {
        titlebar = false;
        border = 0;
      };

      startup = [
        { command = "polybar top"; }
      ];

      keybindings = {
        "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
        "XF86MonBrightnessUp" = "exec brightnessctl set 5%+";

        "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_SINK@ toggle";
        "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_SINK@ 5%-";
        "XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_SINK@ 5%+";

        "${modifier}+d" = "exec --no-startup-id ${menu}";
        "${modifier}+Return" = "exec --no-startup-id ${terminal}";

        "${modifier}+l" = "exec --no-startup-id i3lock -c '#000000'";
        "${modifier}+Shift+e" = "exec --no-startup-id i3-msg exit";

        "${modifier}+Shift+q" = "kill";

        "${modifier}+Shift+c" = "reload";
        "${modifier}+Shift+r" = "restart";

        "${modifier}+b" = "splith";
        "${modifier}+v" = "splitv";

        "${modifier}+s" = "layout stacking";
        "${modifier}+w" = "layout tabbed";
        "${modifier}+e" = "layout toggle split";

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
  };
}