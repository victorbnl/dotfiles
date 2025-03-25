{
  programs.alacritty = {
    enable = true;

    settings = {
      window = {
        opacity = 0.7;
        padding = { x = 10; y = 10; };
      };

      font = {
        size = 11;
      };

      colors = {
        primary = {
          background = "0x000000";
          foreground = "0xb7b8b9";
        };

        normal = {
          black = "0x0c0d0e";
          red = "0xe31a1c";
          green = "0x31a354";
          yellow = "0xdca060";
          blue = "0x3182bd";
          magenta = "0x756bb1";
          cyan = "0x80b1d3";
          white = "0xb7b8b9";
        };

        bright = {
          black = "0x737475";
          red = "0xe31a1c";
          green = "0x31a354";
          yellow = "0xdca060";
          blue = "0x3182bd";
          magenta = "0x756bb1";
          cyan = "0x80b1d3";
          white = "0xfcfdfe";
        };
      };
    };
  };
}
