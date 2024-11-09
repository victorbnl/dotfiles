{
  services.dunst = {
    enable = true;

    settings = {
      global = {
        offset = "10x50";

        padding = 12;
        horizontal_padding = 15;

        frame_width = 0;
        frame_color = "#00000000";

        separator_height = 6;
        separator_color = "#00000000";

        font = "sans-serif 11";

        icon_theme = "Papirus-Dark";
        max_icon_size = 55;

        ellipsize = "end";
      };

      urgency_low = {
        background = "#000000";
        foreground = "#ffffff";
      };

      urgency_normal = {
        background = "#000000";
        foreground = "#ffffff";
      };

      urgency_critical = {
        background = "#c91414";
        foreground = "#ffffff";
      };
    };
  };
}
