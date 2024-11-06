{ pkgs, ... }:
let
  firefox-userchrome = builtins.readFile (builtins.fetchurl "https://git.gay/freeplay/Firefox-Onebar/raw/branch/waf/onebar.css");
in
{
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
}