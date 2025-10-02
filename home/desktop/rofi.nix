{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    papirus-icon-theme
  ];

  programs.rofi = {
    enable = true;

    font = "sans-serif 14.5";

    extraConfig = {
      show-icons = true;
      icon-theme = "Papirus-Dark";
    };

    theme =
      let
        inherit (config.lib.formats.rasi) mkLiteral;
      in
      {
        "*" = {
          background-color = mkLiteral "transparent";
          color = mkLiteral "white";
        };

        "window" = {
          background-color = mkLiteral "black";
        };

        "mainbox" = {
          spacing = mkLiteral "20px";
          padding = mkLiteral "30px";
        };

        "inputbar" = {
          children = mkLiteral "[entry]";
        };

        "element" = {
          padding = mkLiteral "5px";
        };

        "element selected" = {
          background-color = mkLiteral "#111";
        };

        "element-icon" = {
          size = mkLiteral "2.1ch";
          margin = mkLiteral "0 10px";
        };
      };
  };
}
