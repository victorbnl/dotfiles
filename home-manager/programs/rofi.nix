{
  programs.rofi = {
    enable = true;
  };

  xdg.configFile = {
    "rofi/config.rasi".text = ''
      configuration {
        show-icons: true;
        icon-theme: "Papirus Dark";
      }

      @theme "theme.rasi"
    '';

    "rofi/theme.rasi".text = ''
      * {
        background: #000;
        foreground: #fff;
        selected: #111;
      }

      * {
        background-color: transparent;
        font: "sans-serif 14.5";
        color: @foreground;
      }

      window {
        background-color: @background;
      }

      mainbox {
        children: [inputbar, listview];
        spacing: 20px;
        padding: 30px;
      }

      inputbar {
        children: [entry];
      }

      element {
        padding: 5px;
      }

      element-icon {
        size: 2.1ch;
        margin: 0 10px;
      }

      element selected {
        background-color: @selected;
      }
    '';
  };
}
