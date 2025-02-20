{ pkgs, ... }:
let
  background = "#000000";
  foreground = "#FFFFFF";
  idle = "#555555";
  urgent = "#FF0000";
in
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
        inherit background foreground;

        width = "100%";
        height = 32;

        bottom = true;

        padding-left = 0;
        padding-right = 1;

        module-margin-left = 0;
        module-margin-right = 1;

        modules-left = "i3";
        modules-right = "network pulseaudio backlight battery date";

        font = ["IBM Plex Mono Medm:size=13;3"];
      };

      "module/i3" = {
        type = "internal/i3";

        label-mode = "%index%%icon%";
        label-mode-padding = 1;

        label-focused = "%index%%icon%";
        label-focused-padding = 1;

        label-unfocused = "%index%%icon%";
        label-unfocused-foreground = idle;
        label-unfocused-padding = 1;

        label-visible = "%index%%icon%";
        label-visible-padding = 1;

        label-urgent = "%index%%icon%";
        label-urgent-foreground = urgent;
        label-urgent-padding = 1;

        ws-icon = [
          "1;"
          "2;"
          "3;"
        ];
      };

      "module/date" = {
        type = "internal/date";

        format = "[CLK] <label>";
        format-foreground = idle;

        label = "%time%%date%";
        label-foreground = foreground;

        time = "%H:%M";
        date-alt = "%A %d %B %Y";
      };

      "module/network" = {
        type = "internal/network";

        interface-type = "wireless";

        format-connected = "[WLN] <label-connected>";
        format-connected-foreground = idle;

        label-connected = "%essid%";
        label-connected-foreground = foreground;
      };

      "module/pulseaudio" = {
        type = "internal/pulseaudio";

        format-muted = "[VOL] <label-muted>";
        format-muted-foreground = idle;

        format-volume = "[VOL] <label-volume>";
        format-volume-foreground = idle;

        label-volume = "%percentage%%";
        label-volume-foreground = foreground;

        label-muted = "MUTED";
        label-muted-foreground = foreground;
      };

      "module/backlight" = {
        type = "internal/backlight";

        format = "[LGT] <label>";
        format-foreground = idle;
        label-foreground = foreground;
      };

      "module/battery" = {
        type = "internal/battery";

        low-at = 20;

        format-charging = "[BAT] <label-charging>";
        format-charging-foreground = idle;

        format-discharging = "[BAT] <label-discharging>";
        format-discharging-foreground = idle;

        format-full = "[BAT] <label-full>";
        format-full-foreground = idle;

        format-low = "[BAT] <label-low>";
        format-low-foreground = urgent;

        label-charging-foreground = foreground;
        label-discharging-foreground = foreground;
        label-full-foreground = foreground;
        label-low-foreground = foreground;
      };
    };
  };
}
