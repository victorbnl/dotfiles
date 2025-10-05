{ config, lib, pkgs, ... }:
with lib;
{
  options = {
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
    home = {
      # https://github.com/nix-community/home-manager/issues/3113
      packages = mkIf (config.gtk.enable) [ pkgs.dconf ];

      file = {
        ".background-image".source =
          mkIf (config.home.backgroundImage != null) config.home.backgroundImage;

        # https://github.com/nix-community/home-manager/issues/1011
        ".xprofile".text = mkIf config.home.sessionVariablesInXorg ''
          . "${config.home.profileDirectory}/etc/profile.d/hm-session-vars.sh"
        '';
      };
    };

    xdg.configFile."Kvantum/kvantum.kvconfig".text =
      mkIf (config.programs.kvantum.enable) ''
        [General]
        theme=${config.programs.kvantum.theme}
      '';
  };
}
