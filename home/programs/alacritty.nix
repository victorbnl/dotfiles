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
        draw_bold_text_with_bright_colors = true;

        primary = {
          background = "0x000000";
          foreground = "0xffffff";
        };

        normal = {
          black = "0x4d4d4d";
          blue = "0x0f75bd";
          cyan = "0x37c3d6";
          green = "0x86df5d";
          magenta = "0x9e5e83";
          red = "0xd64937";
          white = "0xf9f9f9";
          yellow = "0xfdd75a";
        };

        bright = {
          black = "0x000000";
          blue = "0x0d68a8";
          cyan = "0x288e9c";
          green = "0x61bc3b";
          magenta = "0x744560";
          red = "0x9c3528";
          white = "0xa2a2a2";
          yellow = "0xf3b43a";
        };
      };
    };
  };
}
