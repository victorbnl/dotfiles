{ config, lib, pkgs, ... }:
let
  firefox-userchrome = builtins.readFile (builtins.fetchurl "https://git.gay/freeplay/Firefox-Onebar/raw/branch/waf/onebar.css");
  homeDir = "/home/victor";
in
{
  home.packages = with pkgs; [
    alacritty
    brightnessctl
    dconf # required for gtk
  ];

  xresources.properties = {
    "Xft.dpi" = 134;
  };

  xdg.configFile = {
    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=KvAdaptaDark
    '';

    "qt5ct/settings.ini".text = ''
      [Fonts]
      fixed="Noto Sans,9,-1,5,50,0,0,0,0,0,Regular"
      general="Noto Sans,9,-1,5,50,0,0,0,0,0,Regular"
    '';

    "qt6ct/settings.ini".text = ''
      [Fonts]
      fixed="Noto Sans,9,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular"
      general="Noto Sans,9,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular"
    '';
  };

  home.pointerCursor = {
    package = pkgs.phinger-cursors;
    name = "phinger-cursors-dark";
    gtk.enable = true;
  };

  gtk = {
    enable = true;

    theme = {
      name = "vimix-dark-doder";
      package = pkgs.vimix-gtk-themes;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  services.polybar = {
    enable = true;

    package = pkgs.polybar.override {
      i3Support = true;
      pulseSupport = true;
    };

    script = "polybar top";

    settings = {
      "bar/top" = {
        width = "100%";
        height = 45;

        background = "#000000";
        foreground = "#f2f2f2";

        padding-left = 1;
        padding-right = 3;

        module-margin-left = 2;
        module-margin-right = 2;

        modules-left = "i3";
        modules-center = "date";
        modules-right = "network pulseaudio backlight battery";

        font = [
          "Ubuntu Nerd Font:size=14;3"
        ];
      };

      "module/i3" = {
        type = "internal/i3";

        label-mode = "%index%  %icon%";
        label-mode-padding = 3;

        label-focused = "%index%  %icon%";
        label-focused-padding = 3;

        label-unfocused = "%index%  %icon%";
        label-unfocused-foreground = "#696969";
        label-unfocused-padding = 3;

        label-visible = "%index%  %icon%";
        label-visible-padding = 3;

        label-urgent = "%index%  %icon%";
        label-urgent-foreground = "#ff0000";
        label-urgent-padding = 3;

        ws-icon = [
          "1;󰓇"
          "2;󰖟"
          "3;󰍡"
        ];
      };

      "module/date" = {
        type = "internal/date";

        time = "󰅐  %H:%M";
        date-alt = "󰃭  %A %d %B %Y";

        label = "%time%%date%";
      };

      "module/network" = {
        type = "internal/network";

        interface-type = "wireless";

        label-connected = "󰖩  %essid%";
      };

      "module/pulseaudio" = {
        type = "internal/pulseaudio";

        format-volume = "<ramp-volume>  <label-volume>";
        format-muted = "󰝟  <label-muted>";

        ramp-volume = ["󰖀" "󰕾"];
      };

      "module/backlight" = {
        type = "internal/backlight";

        format = "<ramp>  <label>";

        ramp = ["󰃞" "󰃟" "󰃠"];
      };

      "module/battery" = {
        type = "internal/battery";

        low-at = 20;

        label-low = "󰂃  %percentage%%";
        label-low-foreground = "#ff0000";

        format-low = "<label-low>";
        format-full = "󰁹  <label-full>";
        format-charging = "<animation-charging>  <label-charging>";
        format-discharging = "<ramp-capacity>  <label-discharging>";

        ramp-capacity = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" ];
        animation-charging = [ "󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅" ];
      };
    };
  };

  xsession.windowManager.i3 = {
    enable = true;

    config = rec {
      modifier = "Mod4";
      terminal = "alacritty";
      menu = "dmenu_run";

      window = {
        titlebar = false;
        border = 0;
      };

      startup = [
        { command = "polybar top"; }
      ];

      keybindings = {
        "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
        "XF86MonBrightnessUp" = "exec brightnessctl set 5%+";

        "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_SINK@ toggle";
        "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_SINK@ 5%-";
        "XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_SINK@ 5%+";

        "${modifier}+d" = "exec --no-startup-id ${menu}";
        "${modifier}+Return" = "exec --no-startup-id ${terminal}";

        "${modifier}+Shift+e" = "exec --no-startup-id i3-msg exit";

        "${modifier}+Shift+q" = "kill";

        "${modifier}+Shift+c" = "reload";
        "${modifier}+Shift+r" = "restart";

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

        "${modifier}+agrave" = "workspace number 1";
        "${modifier}+eacute" = "workspace number 2";
        "${modifier}+egrave" = "workspace number 3";
        "${modifier}+ecircumflex" = "workspace number 4";
        "${modifier}+parenleft" = "workspace number 5";
        "${modifier}+parenright" = "workspace number 6";
        "${modifier}+leftsinglequotemark" = "workspace number 7";
        "${modifier}+rightsinglequotemark" = "workspace number 8";
        "${modifier}+guillemotleft" = "workspace number 9";
        "${modifier}+guillemotright" = "workspace number 10";

        "${modifier}+Shift+agrave" = "move container to workspace number 1";
        "${modifier}+Shift+eacute" = "move container to workspace number 2";
        "${modifier}+Shift+egrave" = "move container to workspace number 3";
        "${modifier}+Shift+ecircumflex" = "move container to workspace number 4";
        "${modifier}+Shift+parenleft" = "move container to workspace number 5";
        "${modifier}+Shift+parenright" = "move container to workspace number 6";
        "${modifier}+Shift+leftsinglequotemark" = "move container to workspace number 7";
        "${modifier}+Shift+rightsinglequotemark" = "move container to workspace number 8";
        "${modifier}+Shift+guillemotleft" = "move container to workspace number 9";
        "${modifier}+Shift+guillemotright" = "move container to workspace number 10";
      };

      bars = [];
    };
  };

  services.picom = {
    enable = true;

    backend = "glx";
    vSync = true;
  };

  programs.git = {
    enable = true;

    userEmail = "victor.bonnelle@protonmail.com";
    userName = "Victor Bonnelle";
  };

  programs.firefox = {
    enable = true;

    profiles = {
      default = {
        id = 0;
        name = "default";
        isDefault = true;

        userChrome = firefox-userchrome + ''
          #navigator-toolbox {
            border-bottom: none !important;
          }
        '';

        bookmarks = [
          {
            toolbar = true;
            bookmarks = [
              {
                name = "YouTube";
                url = "https://www.youtube.com";
              }
              {
                name = "Discord";
                url = "https://discord.com";
              }
            ];
          }
        ];

        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          bitwarden
          darkreader
          tabliss
          ublock-origin
        ];

        settings = {
          "extensions.autoDisableScopes" = 0;

          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "browser.tabs.inTitlebar" = 0;

          "browser.contentblocking.category" = "strict";
          "privacy.donottrackheader.enabled" = true;
          "privacy.fingerprintingProtection" = true;
          "privacy.globalprivacycontrol.enabled" = true;

          "browser.translations.automaticallyPopup" = false;
          "browser.aboutConfig.showWarning" = false;
        };
      };
    };
  };

  programs.vscode = {
    enable = true;

    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      formulahendry.code-runner
      shardulm94.trailing-spaces
    ];
  };

  xdg.userDirs = {
    enable = true;

    desktop = "${homeDir}/desktop";
    documents = "${homeDir}/documents";
    download = "${homeDir}/downloads";
    music = "${homeDir}/music";
    pictures = "${homeDir}/pictures";
    publicShare = "${homeDir}/public";
    templates = "${homeDir}/templates";
    videos = "${homeDir}/videos";
  };

  home.stateVersion = "24.05";
}
