{ pkgs, lib, ... }:

{
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
          { class = "nmtui"; }
          { class = "pavucontrol"; }
        ];
      };

      startup = [
        { command = "polybar bar"; notification = false; }
        { command = "${pkgs.xss-lock}/bin/xss-lock --transfer-sleep-lock -- ${pkgs.i3lock-color}/bin/i3lock-color --no-unlock-indicator --color 000000 --image ~/.background-image --fill"; notification = false; }
      ];

      keybindings = {
        "XF86PowerOff" = "exec --no-startup-id rofi-power-menu";

        "XF86MonBrightnessDown" = "exec --no-startup-id ${pkgs.brightnessctl}/bin/brightnessctl set 5%-";
        "XF86MonBrightnessUp" = "exec --no-startup-id ${pkgs.brightnessctl}/bin/brightnessctl set 5%+";

        "XF86AudioMute" = "exec --no-startup-id wpctl set-mute @DEFAULT_SINK@ toggle";
        "XF86AudioLowerVolume" = "exec --no-startup-id wpctl set-volume @DEFAULT_SINK@ 5%-";
        "XF86AudioRaiseVolume" = "exec --no-startup-id wpctl set-volume @DEFAULT_SINK@ 5%+";

        "XF86AudioPlay" = "exec --no-startup-id ${pkgs.playerctl}/bin/playerctl play-pause";

        "${modifier}+b" = "exec --no-startup-id blueman-manager";
        "${modifier}+n" = "exec --no-startup-id alacritty --class nmtui --command nmtui";

        "${modifier}+p" = "exec --no-startup-id rofi-vscode";

        "${modifier}+d" = "exec --no-startup-id ${menu}";
        "${modifier}+Return" = "exec --no-startup-id ${terminal}";
        "${modifier}+e" = "exec --no-startup-id pcmanfm";

        "${modifier}+m" = "exec --no-startup-id ${pkgs.tdrop}/bin/tdrop -y 0 ${terminal} --class dropdown";

        "${modifier}+s" = "exec --no-startup-id ${pkgs.maim}/bin/maim --hidecursor --select --format png | ${pkgs.xclip}/bin/xclip -selection clipboard -t image/png";
        "${modifier}+Shift+s" = "exec --no-startup-id ${pkgs.maim}/bin/maim --hidecursor --format png | ${pkgs.xclip}/bin/xclip -selection clipboard -t image/png";
        "${modifier}+Ctrl+s" = "exec --no-startup-id sleep 2 && ${pkgs.maim}/bin/maim --hidecursor --format png | ${pkgs.xclip}/bin/xclip -selection clipboard -t image/png && dunstify -t 1000 'Screenshot taken'";

        "${modifier}+l" = "exec --no-startup-id loginctl lock-session";
        "${modifier}+Shift+e" = "exec --no-startup-id i3-msg exit";

        "${modifier}+Shift+q" = "kill";

        "${modifier}+Shift+c" = "reload";
        "${modifier}+Shift+r" = "restart";

        "${modifier}+h" = "splith";
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
      }
      // builtins.foldl'
        (set: args:
          set // builtins.listToAttrs (builtins.genList (i:
            let ws = i + 1;
            in {
              name = "${args.mod}+${toString (lib.trivial.mod ws 10)}";
              value = "${args.cmd} ${toString ws}";
            }) 10))
        {}
        [
          { mod = modifier; cmd = "workspace number"; }
          { mod = "${modifier}+Shift"; cmd = "move container to workspace number"; }
        ];

      bars = [];
    };

    extraConfig = ''
      for_window [class="blueman-manager"] resize set 1200 750, move position center
      for_window [class="nmtui"] resize set 1200 750, move position center
      for_window [class="pavucontrol"] resize set 1200 750, move position center
    '';
  };
}
