{ pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.victor = {
    wayland.windowManager.sway = {
      enable = true;

      config = rec {
        modifier = "Mod4";
        terminal = "foot";
        menu = "dmenu_path | wmenu | xargs swaymsg exec --";

        input = {
          "type:keyboard" = {
            xkb_layout = "fr";
            xkb_variant = "afnor";
          };

          "type:touchpad" = {
            tap = "enabled";
          };
        };

        output."*".scale = "1.5";

        keybindings = {
          "${modifier}+Shift+q" = "kill";

          "${modifier}+d" = "exec ${menu}";
          "${modifier}+Return" = "exec ${terminal}";
          "${modifier}+Shift+e" = "exec swaymsg exit";

          "${modifier}+Shift+c" = "reload";

          "${modifier}+b" = "splith";
          "${modifier}+v" = "splitv";

          "${modifier}+s" = "layout stacking";
          "${modifier}+w" = "layout tabbed";
          "${modifier}+e" = "layout toggle split";

          "${modifier}+f" = "fullscreen";

          "${modifier}+space" = "focus mode_toggle";
          "${modifier}+Shift+space" = "floating toggle";

          "${modifier}+minus" = "scratchpad show";
          "${modifier}+Shift+minus" = "move scratchpad";

          "${modifier}+a" = "focus parent";

          "${modifier}+Left" = "focus left";
          "${modifier}+Down" = "focus down";
          "${modifier}+Up" = "focus up";
          "${modifier}+Right" = "focus right";

          "${modifier}+Shift+Left" = "move left";
          "${modifier}+Shift+Down" = "move down";
          "${modifier}+Shift+Up" = "move up";
          "${modifier}+Shift+Right" = "move right";

          "${modifier}+0xe0" = "workspace number 1";
          "${modifier}+0xe9" = "workspace number 2";
          "${modifier}+0xe8" = "workspace number 3";
          "${modifier}+0xea" = "workspace number 4";
          "${modifier}+0x28" = "workspace number 5";
          "${modifier}+0x29" = "workspace number 6";
          "${modifier}+0x2018" = "workspace number 7";
          "${modifier}+0x2019" = "workspace number 8";
          "${modifier}+0xab" = "workspace number 9";
          "${modifier}+0xbb" = "workspace number 10";

          "${modifier}+Shift+0xe0" = "move container to workspace number 1";
          "${modifier}+Shift+0xe9" = "move container to workspace number 2";
          "${modifier}+Shift+0xe8" = "move container to workspace number 3";
          "${modifier}+Shift+0xea" = "move container to workspace number 4";
          "${modifier}+Shift+0x28" = "move container to workspace number 5";
          "${modifier}+Shift+0x29" = "move container to workspace number 6";
          "${modifier}+Shift+0x2018" = "move container to workspace number 7";
          "${modifier}+Shift+0x2019" = "move container to workspace number 8";
          "${modifier}+Shift+0xab" = "move container to workspace number 9";
          "${modifier}+Shift+0xbb" = "move container to workspace number 10";
        };
      };
    };

    programs.firefox = {
      enable = true;

      profiles = {
        default = {
          id = 0;
          name = "default";
          isDefault = true;

          extensions = with pkgs.nur.repos.rycee.firefox-addons; [
            ublock-origin
            bitwarden
            darkreader
          ];
        };
      };
    };

    home.stateVersion = "24.05";
  };
}
