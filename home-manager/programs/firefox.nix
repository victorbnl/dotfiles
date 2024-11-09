{ nur, firefox-onebar, ... }:

{
  programs.firefox = {
    enable = true;

    profiles = {
      default = {
        id = 0;
        name = "default";
        isDefault = true;

        userChrome = (builtins.readFile firefox-onebar) + ''
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
                url = "https://www.youtube.com/";
              }
              {
                name = "Twitch";
                url = "https://www.twitch.tv/";
              }
            ];
          }
        ];

        extensions = with nur.repos.rycee.firefox-addons; [
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
