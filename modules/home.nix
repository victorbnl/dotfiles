{ config, lib, ... }:
with lib;
{
  options ={
    home = {
      backgroundImage = mkOption {
        default = null;
        type = types.nullOr types.path;
      };

      sessionVariablesInXorg = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Session variables are set through the shell. This means that they are
          not available to any other app by default. This options allows loading
          them as X starts, provided the display manager sources `~/.xprofile`.
        '';
      };
    };

    programs.kvantum = {
      enable = mkEnableOption "kvantum";

      theme = mkOption {
        default = "Kvantum";
        type = types.str;
      };
    };
  };

  config = {
    home.file = {
      ".background-image".source =
        mkIf (config.home.backgroundImage != null) config.home.backgroundImage;

      ".xprofile".text = mkIf config.home.sessionVariablesInXorg ''
        . "${config.home.profileDirectory}/etc/profile.d/hm-session-vars.sh"
      '';
    };

    xdg.configFile."Kvantum/kvantum.kvconfig".text =
      mkIf (config.programs.kvantum.enable) ''
        [General]
        theme=${config.programs.kvantum.theme}
      '';
  };
}
