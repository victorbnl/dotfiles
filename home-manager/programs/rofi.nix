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
        background-color: transparent;
        color: white;

        font: "sans-serif 14.5";
      }

      window {
        background-color: black;
      }

      mainbox {
        spacing: 20px;
        padding: 30px;
      }

      inputbar {
        children: [entry];
      }

      element {
        padding: 5px;
      }

      element selected {
        background-color: #111;
      }

      element-icon {
        size: 2.1ch;
        margin: 0 10px;
      }
    '';
  };
}
