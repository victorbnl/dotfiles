{ pkgs, ... }:

{
  services.polybar = {
    enable = true;

    package = pkgs.polybar.override {
      i3Support = true;
      pulseSupport = true;
    };

    script = "polybar bar";

    settings = {
      "bar/bar" = {
        width = "100%";
        height = 45;

        bottom = true;

        background = "#000000";
        foreground = "#f2f2f2";

        padding-left = 1;
        padding-right = 4;

        module-margin-left = 2;
        module-margin-right = 2;

        modules-left = "i3";
        modules-right = "network pulseaudio backlight battery date";

        font = [
          "Ubuntu Nerd Font:size=14;3"
        ];
      };

      "module/i3" = {
        type = "internal/i3";

        label-mode = "%index%  %icon%";
        label-mode-padding = 3;

        label-focused = "%index%  %icon%";
        label-focused-padding = 3;

        label-unfocused = "%index%  %icon%";
        label-unfocused-foreground = "#696969";
        label-unfocused-padding = 3;

        label-visible = "%index%  %icon%";
        label-visible-padding = 3;

        label-urgent = "%index%  %icon%";
        label-urgent-foreground = "#ff0000";
        label-urgent-padding = 3;

        ws-icon = [
          "1;󰓇"
          "2;󰈹"
          "3;󰭹"
        ];
      };

      "module/date" = {
        type = "internal/date";

        time = "󰅐  %H:%M";
        date-alt = "󰃭  %A %d %B %Y";

        label = "%time%%date%";
      };

      "module/network" = {
        type = "internal/network";

        interface-type = "wireless";

        label-connected = "󰖩  %essid%";
      };

      "module/pulseaudio" = {
        type = "internal/pulseaudio";

        format-volume = "<ramp-volume>  <label-volume>";
        format-muted = "󰝟  <label-muted>";

        ramp-volume = ["󰖀" "󰕾"];
      };

      "module/backlight" = {
        type = "internal/backlight";

        format = "<ramp>  <label>";

        ramp = ["󰃞" "󰃟" "󰃠"];
      };

      "module/battery" = {
        type = "internal/battery";

        low-at = 20;

        label-low = "󰂃  %percentage%%";
        label-low-foreground = "#ff0000";

        format-low = "<label-low>";
        format-full = "󰁹  <label-full>";
        format-charging = "<animation-charging>  <label-charging>";
        format-discharging = "<ramp-capacity>  <label-discharging>";

        ramp-capacity = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" ];
        animation-charging = [ "󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅" ];
      };
    };
  };
}
