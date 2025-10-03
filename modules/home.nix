{ config, lib, ... }:
with lib;
let
  cfg = config.home;
in
{
  options ={
    home.backgroundImage = mkOption {
      default = null;
      type = types.nullOr types.path;
    };

    home.sessionVariablesInXorg = mkOption {
      default = false;
      type = types.bool;
      description = ''
        Session variables are set through the shell. This means that they are
        not available to any other app by default. This options allows loading
        them as X starts, provided the display manager sources `~/.xprofile`.
      '';
    };
  };

  config = {
    home.file = {
      ".background-image".source = mkIf (cfg.backgroundImage != null) cfg.backgroundImage;

      ".xprofile".text = mkIf cfg.sessionVariablesInXorg ''
        . "${config.home.profileDirectory}/etc/profile.d/hm-session-vars.sh"
      '';
    };
  };
}
